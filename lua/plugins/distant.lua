return {
  {
    'chipsenkbeil/distant.nvim', 
    branch = 'v0.3',
    cmd = {
      "DistantLaunch",
      "DistantOpen",
      "DistantConnect",
      "DistantInstall",
      "DistantMetadata",
      "DistantShell",
      "DistantShell",
      "DistantSystemInfo",
      "DistantClientVersion",
      "DistantSessionInfo",
      "DistantCopy",
    },
    config = function()
        require('distant'):setup()
    end
  },
}
