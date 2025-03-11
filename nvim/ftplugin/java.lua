local home = os.getenv("HOME")
local jdtls_dir = home .. '/prog/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/'
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

local jdtls_setup = require("jdtls.setup")

local root_dir = jdtls_setup.find_root(root_markers)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

--print(project_name)
--print(root_dir)
--print(workspace_dir)

local function get_config_dir()
  if vim.fn.has('linux') == 1 then
    return 'config_linux'
  elseif vim.fn.has('mac') == 1 then
    return 'config_mac'
  else
    return 'config_win'
  end
end

local jdtls_config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=INFO',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', jdtls_dir .. 'plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar',
        '-configuration', jdtls_dir .. get_config_dir(),
        '-data', workspace_dir
    },
    root_dir = root_dir,
    settings = {
        java = {
            project = {
                referencedLibraries = {
                    root_dir .. "/libs/*.jar",
                    root_dir .. "/lib/*.jar",
                }
            }
        }
    }
}

require('jdtls').start_or_attach(jdtls_config)
