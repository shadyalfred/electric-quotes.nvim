# electric-quotes.nvim

See [https://www.gnu.org/software/emacs/manual/html_node/emacs/Quotation-Marks.html](https://www.gnu.org/software/emacs/manual/html_node/emacs/Quotation-Marks.html)

## How it works

It automatically replaces

| From       | To   |
|------------|------|
| ``` ` ```  | `‘`  |
| ``` `` ``` | `“`  |
| `'`        | `’`  |
| `''`       | `”`  |

## Command
`ElectricQuotesToggle` is exposed, to enable and disable the plugin (it has to be enabled to work).

## Installation

```lua
use {
  'shadyalfred/electric-quotes.nvim',
  requires = {
    'uga-rosa/utf8.nvim',
  }
}
```
