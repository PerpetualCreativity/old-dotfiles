 module.exports = {
    defaultBrowser: "Safari",
    handlers: [
        {
            match: finicky.matchHostnames(["youtube.com", "google.com"]),
            browser: "Google Chrome"
        },
        {
            match: finicky.matchHostnames(["outlook.com", "microsoft.com", "edupoint.com"]),
            browser: "Microsoft Edge"
        },
        {
            match: ({ sourceBundleIdentifier }) => sourceBundleIdentifier === "com.hnc.Discord",
            browser: "Firefox"
        },
        {
            match: ({ keys }) => keys.function,
            browser: "Firefox"
        },
        {
            match: ({ keys }) => keys.option,
            browser: "Safari"
        }
    ]
};

