# mecab-cookbook

Installs [MeCab](https://code.google.com/p/mecab/) from source code.

This cookbook contains fix of [memory bug](https://code.google.com/p/mecab/issues/detail?id=5) for mecab-0.996

## Supported Platforms

Tested on Ubuntu 14.04  
Your feedback is appreciated.

## Attributes

<!-- <table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mecab']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table> -->

## Usage

### mecab::default

Include `mecab` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[mecab::default]"
  ]
}
```


### Contributing

0. Fork the repository on Github
* Create a named feature branch (like `feature/add_awesome_feature`)
* Write you change
* Write tests for your change (if applicable)
* Run the tests, ensuring they all pass
* Submit a Pull Request using Github


## License and Authors
License:: MIT

Author:: hgs (https://github.com/hgs)
