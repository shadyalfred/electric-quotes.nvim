# electric-quotes.nvim

See [https://www.gnu.org/software/emacs/manual/html_node/emacs/Quotation-Marks.html](https://www.gnu.org/software/emacs/manual/html_node/emacs/Quotation-Marks.html)

https://github.com/shadyalfred/electric-quotes.nvim/assets/3685582/212199e3-ed6c-438a-94d6-d342e7c8bdfe

## How it works

It automatically converts

| This       | Into  |
|------------|------|
| ``` ` ```  | `‘`  |
| ``` `` ``` | `“`  |
| `'`        | `’`  |
| `''`       | `”`  |

## Command
`ElectricQuotesToggle` is exposed, to enable and disable the plugin (it has to be enabled to work).

## Installation

### Packer

```lua
use {
  'shadyalfred/electric-quotes.nvim',
  requires = {
    'uga-rosa/utf8.nvim',
  }
}
```
