-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        -- Adding esqueleto for templates
        "cvigilv/esqueleto.nvim",
        opts = {
            -- Default templates directory
            directories = { "~/.config/nvim/skeletons/" },

            -- Patterns to detect for template insetion (empty by default,
            -- adding as an example)
            patterns = {
                -- File specific
                "LICENSE",
                "main.c",
                "main.cpp",

                -- File type
                "python",
                "c",
                "h",
                "html",
                "julia",
                "cpp",
                "hpp",
                "tex",
            },

            -- Advanced options
            advanced = {
                ignore_os_files = true,
                ignore = {},
            },
        },
    },
}
