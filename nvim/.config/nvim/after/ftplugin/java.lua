local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"

local root_markers = { "gradlew", "pom.xml", ".git", "mvnw", "build.gradle" }

local root_dir = require("jdtls.setup").find_root(root_markers)

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), "p:h:t")

local workspace_folder = os.getenv("HOME")
    .. "/personal/jdtls-workspace/"
    .. project_name

if vim.fn.has("mac") == 1 then
    OS_NAME = "mac"
elseif vim.fn.has("unix") == 1 then
    OS_NAME = "linux"
elseif vim.fn.has("win32") == 1 then
    OS_NAME = "win"
else
    vim.notify("Unsupported OS", vim.log.levels.WARN, { title = "Jdtls" })
end

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens java.base/java.util=ALL-UNNAMED",
        "--add-opens java.base/java.lang=ALL-UNNAMED",

        "-jar",
        jdtls_path .. "plugins/org.eclipse.equinox.launcher_*.jar",
        "-configuration",
        jdtls_path .. "config_" .. OS_NAME,
        -- Our dedicated JDTLS workspace
        "-data",
        workspace_folder,
    },
    root_dir = root_dir,
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = os.getenv("JAVA_HOME"),
                    },
                },
            },
        },
    },
}

require("jdtls").start_or_attach(config)
