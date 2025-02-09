local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
print(project_name)

local home = os.getenv("HOME")
local workspace_dir = home .. '/prog/' .. project_name
local jdtls_dir = home .. '/prog/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/'

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
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
    settings = {
        java = {
            project = {
                referencedLibraries = { "/home/mo/prog/jmh-test/libs/jmh-core-1.37.jar" }
            }
        }
    }
}

require('jdtls').start_or_attach(jdtls_config)
