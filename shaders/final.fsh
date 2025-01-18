#version 120

uniform sampler2D gbufferColor;

// Attempt to use a common uniform for screen resolution
uniform vec2 screenSize; // Hypothetical uniform; replace if necessary

#define pixelSize 10.0 //[1.0 2.0 5.0 7.5 10.0 12.5 15.0 20.0 30.0 40.0 50.0 75.0 100.0 200.0 500.0 1000.0];
#define screenWidth 1920.0 //[640.0 800.0  1024.0 1280.0 1360.0 1366.0 1440.0 1536.0 1600.0 1680.0 1708.0 1920.0 2048.0 2560.0 3440.0 3840.0 4096.0 7680.0]
#define screenHeight 1080.0 //[360.0 480.0 600.0 720.0 768.0 800.0 864.0 900.0 966.0 1024.0 1050.0 1080.0 1152.0 1200.0 1440.0 1536.0 1600.0 2160.0 2304.0]

void main() {
    // Fallback to hardcoded resolution if screenSize doesn't work
    vec2 resolution = screenSize != vec2(0.0, 0.0) ? screenSize : vec2(screenWidth, screenHeight);

    vec2 uv = gl_FragCoord.xy / resolution;

    // Apply pixelation by rounding UV coordinates
    uv = floor(uv * (resolution / pixelSize)) / (resolution / pixelSize);

    // Sample the texture at the modified UV coordinates
    vec4 color = texture2D(gbufferColor, uv);
    
    // Output the pixelated color
    gl_FragColor = color;
}
