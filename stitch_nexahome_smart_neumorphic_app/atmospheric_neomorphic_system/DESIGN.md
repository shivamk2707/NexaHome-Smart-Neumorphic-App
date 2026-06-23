---
name: Atmospheric Neomorphic System
colors:
  surface: '#f9f9fc'
  surface-dim: '#dadadc'
  surface-bright: '#f9f9fc'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f6'
  surface-container: '#eeeef0'
  surface-container-high: '#e8e8ea'
  surface-container-highest: '#e2e2e5'
  on-surface: '#1a1c1e'
  on-surface-variant: '#494455'
  inverse-surface: '#2f3133'
  inverse-on-surface: '#f0f0f3'
  outline: '#7a7487'
  outline-variant: '#cac3d8'
  surface-tint: '#6833ea'
  primary: '#632ce5'
  on-primary: '#ffffff'
  primary-container: '#7c4dff'
  on-primary-container: '#fcf6ff'
  inverse-primary: '#cdbdff'
  secondary: '#0058bd'
  on-secondary: '#ffffff'
  secondary-container: '#1e70e4'
  on-secondary-container: '#fefcff'
  tertiary: '#565a5c'
  on-tertiary: '#ffffff'
  tertiary-container: '#6f7275'
  on-tertiary-container: '#f6f8fb'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e8deff'
  primary-fixed-dim: '#cdbdff'
  on-primary-fixed: '#20005f'
  on-primary-fixed-variant: '#4f00d0'
  secondary-fixed: '#d8e2ff'
  secondary-fixed-dim: '#adc6ff'
  on-secondary-fixed: '#001a42'
  on-secondary-fixed-variant: '#004495'
  tertiary-fixed: '#e0e3e6'
  tertiary-fixed-dim: '#c4c7ca'
  on-tertiary-fixed: '#191c1e'
  on-tertiary-fixed-variant: '#44474a'
  background: '#f9f9fc'
  on-background: '#1a1c1e'
  surface-variant: '#e2e2e5'
typography:
  display:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '600'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '500'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 26px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 16px
  margin-mobile: 20px
  margin-desktop: 40px
---

## Brand & Style

This design system is built on the principles of **Neomorphism**, emphasizing tactile depth and physical realism within a digital space. The goal is to create a premium, "molded" interface where UI elements appear to be extruded from or recessed into the background material. 

The personality is sophisticated, calm, and high-tech, drawing inspiration from high-end automotive interfaces and smart-home hardware. By utilizing soft, dual-shadow techniques (light and dark), we create a sense of presence and materiality that feels more organic than traditional flat design. 

The emotional response should be one of "effortless control." The interface behaves like a physical panel of soft-touch materials, providing clear affordances through shadow-based depth rather than high-contrast color shifts.

## Colors

The palette is centered around two monochromatic base states that serve as the "material" for the entire UI.

- **Light Mode:** Uses `#F0F2F5` as the canvas. Depth is achieved using pure white for top-left highlights and a muted blue-gray (`#D1D9E6`) for bottom-right shadows.
- **Dark Mode:** Uses `#1A1C1E` as the canvas. Depth is achieved using a subtle charcoal lift (`#25282C`) and a deep obsidian base (`#0F1012`).
- **Accents:** A vibrant Violet-to-Blue gradient is reserved strictly for active states, interactive "on" buttons, and data visualizations (like temperature or brightness arcs). This provides a sharp, glowing contrast against the soft base material.

## Typography

This design system utilizes **Inter** across all levels to maintain a clean, systematic, and highly legible appearance. 

The type hierarchy is designed to be unobtrusive, allowing the shadow-based UI to lead the visual experience. Large "Display" and "Headline" sizes are used for high-level information like room names or current temperature readings. "Labels" use slightly heavier weights and increased letter spacing to ensure clarity when placed inside recessed "well" elements or on top of raised buttons.

## Layout & Spacing

The layout follows a strict **8pt grid system** to ensure mathematical harmony between elements. 

- **Fluid Grid:** Content primarily uses a fluid model for mobile devices, with a focus on vertical scrolling of "card stacks."
- **Margins:** 20px safe margins are maintained on mobile to prevent content from hitting the screen edge.
- **Stacking:** Elements are grouped in logical containers (e.g., "Kitchen Controls") with 24px spacing between cards.
- **Internal Padding:** Large cards use a minimum of 24px internal padding to provide "breathing room" for neomorphic shadows, ensuring they don't overlap with child elements.

## Elevation & Depth

Hierarchy is communicated through three specific neomorphic states:

1.  **Raised (Default):** Elements appear to "float" above the background. This is achieved using two shadows: a light shadow (`-6px -6px 12px` spread) and a dark shadow (`6px 6px 12px` spread).
2.  **Sunken (Pressed/Inactive Wells):** Elements appear recessed into the surface. This uses `inset` shadows with the same light/dark logic. Used for backgrounds of sliders, toggles, and inactive buttons.
3.  **Floating (Primary Actions):** Floating action buttons use a more aggressive shadow spread and a subtle glowing outer shadow in the primary violet color to indicate high importance.

Avoid "stacking" raised elements on top of other raised elements. A raised card should only contain flat or recessed elements.

## Shapes

The shape language is dominated by **large, friendly radii**. 

- **Primary Cards:** Use a 24px or 32px radius to create a soft, pillowy aesthetic.
- **Buttons & Toggles:** Use a fully rounded (pill-shaped) radius for small controls.
- **Sliders:** The "track" of sliders should be recessed with a radius that matches the width of the track, while the "thumb" or "handle" should be a raised circle.
- **Inner Elements:** When an element is placed inside a card, its radius should be slightly smaller than the parent card (e.g., a 16px child inside a 24px parent) to maintain visual nesting harmony.

## Components

### Buttons
- **Default:** Raised neomorphic state with the same color as the background.
- **Active/On:** Raised state with the Primary Gradient background and a glowing outer shadow.
- **Icon Buttons:** Small 48x48 circles with 12px shadows.

### Custom Toggles
- The toggle track is a recessed "well" (`inset` shadows).
- The toggle thumb is a raised circular element that slides horizontally.
- When "On", the track glows with a subtle primary color tint.

### Circular Sliders (Thermostat/Dimmer)
- A large circular recessed track.
- The active portion of the track is filled with the Primary Gradient.
- The center of the circle features a large raised neomorphic "dial" containing the numerical value.

### Cards
- Large containers for device groups. 
- Must use a 24px radius minimum.
- Shadows must be soft and diffused (blur radius should be 2x the offset).

### Input Fields
- Always recessed (`inset` shadows) to appear like a slot in the hardware.
- Text is vertically centered with a "Label-MD" typography style.