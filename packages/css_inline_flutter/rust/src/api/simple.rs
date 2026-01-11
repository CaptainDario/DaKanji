#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

/// Inlines CSS from style/link tags into style attributes.
/// Returns the resulting HTML as a String.
pub fn inline_css(html: String) -> anyhow::Result<String> {
    // We map the css_inline error to an anyhow error so FRB can pass it to Dart
    css_inline::inline(&html)
        .map_err(|e| anyhow::anyhow!("CSS Inlining failed: {}", e))
}

/// Synchornous version of inline_css
#[flutter_rust_bridge::frb(sync)] 
pub fn inline_css_sync(html: String) -> anyhow::Result<String> {
    css_inline::inline(&html)
        .map_err(|e| anyhow::anyhow!("CSS Inlining failed: {}", e))
}

/// Inlines a specific CSS string into an HTML fragment.
/// Useful for partial templates where you provide the CSS separately.
pub fn inline_fragment(html: String, css: String) -> anyhow::Result<String> {
    css_inline::inline_fragment(&html, &css)
        .map_err(|e| anyhow::anyhow!("Fragment Inlining failed: {}", e))
}

/// Synchronous version of inline_fragment
#[flutter_rust_bridge::frb(sync)] 
pub fn inline_fragment_sync(html: String, css: String) -> anyhow::Result<String> {
    css_inline::inline_fragment(&html, &css)
        .map_err(|e| anyhow::anyhow!("Fragment Inlining failed: {}", e))
}