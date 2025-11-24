# Linux Dotfiles

A minimal, keyboard-driven Linux desktop environment using i3wm, Kitty, Zsh with Powerlevel10k, and Rofi. Built on EndevourOS i3vm setup

---

## What's Included

- **i3wm** - Tiling window manager
- **Kitty** - GPU-accelerated terminal emulator
- **Zsh + Oh My Zsh** - Modern shell with plugins
- **Powerlevel10k** - Beautiful, fast shell prompt
- **Rofi** - Application launcher with custom themes
- **Conky** - System monitor displaying real-time information
- **Picom** - Compositor for transparency and visual effects

---

# Keyboard Shortcuts Reference

## i3wm Keybindings

| Keybinding | Action |
|------------|--------|
| `$mod+Enter` | Open terminal |
| `$mod+d` | Application launcher |
| `$mod+t` | Select opened window |
| `$mod+Shift+q` | Quick Links |
| `$mod+c` | Clipboard menu |
| `$mod+y` | Screenshot tool |
| `$mod+q` | Kill focused window |
| `$mod+Shift+e` | Power menu |
| `$mod+Tab` | Window switcher/selector |
| `$mod+1-9` | Switch workspace |
| `$mod+Shift+1-9` | Move window to workspace |
| `$mod+Shift+c` | Reload i3 config |
| `$mod+Shift+r` | Restart i3 |
| `$mod+left/down/up/right` | Focus left/down/up/right USE ARROWKEYS |
| `$mod+Shift+left/down/up/right` | Move window |

---

## Kitty Terminal Shortcuts

### Tabs Management
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+Q` | Close tab |
| `Ctrl+Shift+Right` | Next tab |
| `Ctrl+Shift+Left` | Previous tab |
| `Ctrl+Shift+.` | Move tab forward |
| `Ctrl+Shift+,` | Move tab backward |
| `Ctrl+Shift+Alt+T` | Set tab title |

### Windows Management
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+Enter` | New window |
| `Ctrl+Shift+W` | Close window |
| `Ctrl+Shift+]` | Next window |
| `Ctrl+Shift+[` | Previous window |
| `Ctrl+Shift+F` | Move window forward |
| `Ctrl+Shift+B` | Move window backward |
| `Ctrl+Shift+\`` | Move window to top |
| `Ctrl+Shift+1` to `9` | Focus specific window |

### Scrolling
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+Up` | Scroll line up |
| `Ctrl+Shift+Down` | Scroll line down |
| `Ctrl+Shift+Page Up` | Scroll page up |
| `Ctrl+Shift+Page Down` | Scroll page down |
| `Ctrl+Shift+Home` | Scroll to top |
| `Ctrl+Shift+End` | Scroll to bottom |
| `Ctrl+Shift+H` | Show scrollback in pager |

### Copy/Paste
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |
| `Ctrl+Shift+S` | Paste from selection |
| `Ctrl+Shift+O` | Pass selection to program |

### Font Sizes
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+Equal` | Increase font size |
| `Ctrl+Shift+Minus` | Decrease font size |
| `Ctrl+Shift+Backspace` | Reset font size |

### Miscellaneous
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+F2` | Edit config file |
| `Ctrl+Shift+F5` | Reload config file |
| `Ctrl+Shift+F6` | Debug config |
| `Ctrl+Shift+Delete` | Clear terminal |
| `Ctrl+Shift+E` | Open URL with hints |
| `Ctrl+Shift+Escape` | Kitty shell |
| `Ctrl+Shift+F11` | Toggle fullscreen |
| `Ctrl+Shift+F1` | Show documentation |

---

## VSCode Shortcuts

### General
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+P` | Show Command Palette |
| `Ctrl+P` | Quick Open, Go to File |
| `Ctrl+Shift+N` | New window/instance |
| `Ctrl+Shift+W` | Close window/instance |
| `Ctrl+,` | User Settings |
| `Ctrl+K Ctrl+S` | Keyboard Shortcuts |

### Basic Editing
| Shortcut | Action |
|----------|--------|
| `Ctrl+X` | Cut line (empty selection) |
| `Ctrl+C` | Copy line (empty selection) |
| `Alt+Up/Down` | Move line up/down |
| `Shift+Alt+Up/Down` | Copy line up/down |
| `Ctrl+Shift+K` | Delete line |
| `Ctrl+Enter` | Insert line below |
| `Ctrl+Shift+Enter` | Insert line above |
| `Ctrl+Shift+\` | Jump to matching bracket |
| `Ctrl+]/[` | Indent/outdent line |
| `Ctrl+/` | Toggle line comment |
| `Shift+Alt+A` | Toggle block comment |
| `Alt+Z` | Toggle word wrap |

### Navigation
| Shortcut | Action |
|----------|--------|
| `Ctrl+G` | Go to Line |
| `Ctrl+P` | Go to File |
| `Ctrl+Shift+O` | Go to Symbol |
| `Ctrl+T` | Show all Symbols |
| `Ctrl+Shift+M` | Show Problems panel |
| `F8` | Go to next error or warning |
| `Shift+F8` | Go to previous error or warning |
| `Alt+Left/Right` | Go back/forward |
| `Ctrl+Home` | Go to beginning of file |
| `Ctrl+End` | Go to end of file |

### Search and Replace
| Shortcut | Action |
|----------|--------|
| `Ctrl+F` | Find |
| `Ctrl+H` | Replace |
| `F3` | Find next |
| `Shift+F3` | Find previous |
| `Alt+Enter` | Select all occurrences of Find match |
| `Ctrl+D` | Add selection to next Find match |
| `Ctrl+K Ctrl+D` | Move last selection to next Find match |

### Multi-cursor and Selection
| Shortcut | Action |
|----------|--------|
| `Alt+Click` | Insert cursor |
| `Ctrl+Alt+Up/Down` | Insert cursor above/below |
| `Ctrl+U` | Undo last cursor operation |
| `Shift+Alt+I` | Insert cursor at end of each line |
| `Ctrl+L` | Select current line |
| `Ctrl+Shift+L` | Select all occurrences of current selection |
| `Ctrl+F2` | Select all occurrences of current word |
| `Shift+Alt+Right` | Expand selection |
| `Shift+Alt+Left` | Shrink selection |

### Rich Language Editing
| Shortcut | Action |
|----------|--------|
| `Ctrl+Space` | Trigger suggestion |
| `Ctrl+Shift+Space` | Trigger parameter hints |
| `Shift+Alt+F` | Format document |
| `Ctrl+K Ctrl+F` | Format selection |
| `F12` | Go to Definition |
| `Alt+F12` | Peek Definition |
| `Ctrl+K F12` | Open Definition to the side |
| `Ctrl+.` | Quick Fix |
| `Shift+F12` | Show References |
| `F2` | Rename Symbol |

### Editor Management
| Shortcut | Action |
|----------|--------|
| `Ctrl+W` | Close editor |
| `Ctrl+K F` | Close folder |
| `Ctrl+\` | Split editor |
| `Ctrl+1/2/3` | Focus into editor group |
| `Ctrl+K Ctrl+Left/Right` | Focus previous/next editor group |

### File Management
| Shortcut | Action |
|----------|--------|
| `Ctrl+N` | New File |
| `Ctrl+O` | Open File |
| `Ctrl+S` | Save |
| `Ctrl+Shift+S` | Save As |
| `Ctrl+K S` | Save All |
| `Ctrl+F4` | Close |
| `Ctrl+K Ctrl+W` | Close All |
| `Ctrl+Shift+T` | Reopen closed editor |

### Display
| Shortcut | Action |
|----------|--------|
| `F11` | Toggle full screen |
| `Ctrl+B` | Toggle Sidebar visibility |
| `Ctrl+Shift+E` | Show Explorer |
| `Ctrl+Shift+F` | Show Search |
| `Ctrl+Shift+G` | Show Source Control |
| `Ctrl+Shift+D` | Show Debug |
| `Ctrl+Shift+X` | Show Extensions |
| `Ctrl+=/-` | Zoom in/out |
| `Ctrl+K Z` | Zen Mode (Esc Esc to exit) |

### Debug
| Shortcut | Action |
|----------|--------|
| `F9` | Toggle breakpoint |
| `F5` | Start/Continue |
| `Shift+F5` | Stop |
| `F11` | Step into |
| `Shift+F11` | Step out |
| `F10` | Step over |

### Integrated Terminal
| Shortcut | Action |
|----------|--------|
| ``Ctrl+` `` | Show integrated terminal |
| ``Ctrl+Shift+` `` | Create new terminal |
| `Ctrl+C` | Copy selection |
| `Ctrl+V` | Paste into active terminal |
| `Ctrl+Up/Down` | Scroll up/down |
| `Shift+PgUp/PgDown` | Scroll page up/down |

---

**Note:** `$mod` is the Windows/Super key by default. It can be changed on top of i3wm config file

---

# Resources

- [i3wm Documentation](https://i3wm.org/docs/userguide.html)
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
- [Oh My Zsh Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [adi1090x Rofi Collection](https://github.com/adi1090x/rofi)
- [Dotfiles Management Guide](https://www.atlassian.com/git/tutorials/dotfiles)
- [Kitty + Zsh + P10k Setup Guide](https://dev.to/protium/kitty-zsh-powerlevel10k-aesthetics-1e81)

---

# Credits

- i3wm community for tiling window manager workflows
- Aditya Shakya (adi1090x) for the beautiful Rofi collection
- Roman Perepelitsa for Powerlevel10k theme
- Oh My Zsh community for plugins ecosystem
- Dotfiles community for bare repository method

