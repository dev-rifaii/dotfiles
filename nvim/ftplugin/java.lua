local jdtls_config = {
    cmd = { 'jdtls' },
    root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
    settings = {
        java = {}
    }
}

require('jdtls').start_or_attach(jdtls_config)
