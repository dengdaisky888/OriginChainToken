#
#  Panoramix v4 Oct 2019 
#  Decompiled source of 0xB81aaBd91528a02136F194be78F93E640B2BE5c3
# 
#  Let's make the world open source 
# 

def storage:
  totalSupply is uint256 at storage 0
  balanceOf is mapping of uint256 at storage 1
  allowance is mapping of uint256 at storage 2
  name is array of uint256 at storage 3
  decimals is uint8 at storage 4
  symbol is array of uint256 at storage 5
  owner is addr at storage 6

def name(): # not payable
  return name[0 len name.length]

def totalSupply(): # not payable
  return totalSupply

def decimals(): # not payable
  return decimals

def balanceOf(address _owner): # not payable
  return balanceOf[addr(_owner)]

def owner(): # not payable
  return owner

def symbol(): # not payable
  return symbol[0 len symbol.length]

def allowance(address _owner, address _spender): # not payable
  return allowance[addr(_owner)][addr(_spender)]

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def approve(address _spender, uint256 _value): # not payable
  allowance[caller][addr(_spender)] = _value
  log Approval(
        address owner=_value,
        address spender=caller,
        uint256 value=_spender)
  return 1

def burn(uint256 _value): # not payable
  require balanceOf[caller] >= _value
  require _value <= balanceOf[caller]
  balanceOf[caller] -= _value
  require _value <= totalSupply
  totalSupply -= _value
  log Transfer(
        address from=_value,
        address to=caller,
        uint256 value=0)
  return 1

def unknown39dbcb63(addr _param1, uint256 _param2): # not payable
  require _param2 <= allowance[caller][addr(_param1)]
  allowance[caller][addr(_param1)] -= _param2
  log Approval(
        address owner=(allowance[caller][addr(_param1)] - _param2),
        address spender=caller,
        uint256 value=_param1)
  return 1

def mint(uint256 _wad): # not payable
  require owner == caller
  require balanceOf[caller] + _wad >= balanceOf[caller]
  balanceOf[caller] += _wad
  require totalSupply + _wad >= totalSupply
  totalSupply += _wad
  require totalSupply <= 500 * 10^6 * 10^decimals
  log Transfer(
        address from=_wad,
        address to=0,
        uint256 value=caller)
  return 1

def unknown421f1461(addr _param1, uint256 _param2): # not payable
  require allowance[caller][addr(_param1)] + _param2 >= allowance[caller][addr(_param1)]
  allowance[caller][addr(_param1)] += _param2
  log Approval(
        address owner=(allowance[caller][addr(_param1)] + _param2),
        address spender=caller,
        uint256 value=_param1)
  return 1

def transfer(address _to, uint256 _value): # not payable
  require _to
  require balanceOf[caller] >= _value
  require _value <= balanceOf[caller]
  balanceOf[caller] -= _value
  require balanceOf[addr(_to)] + _value >= balanceOf[addr(_to)]
  balanceOf[addr(_to)] += _value
  log Transfer(
        address from=_value,
        address to=caller,
        uint256 value=_to)
  return 1

def transferFrom(address _from, address _to, uint256 _value): # not payable
  require _to
  require balanceOf[addr(_from)] >= _value
  require allowance[addr(_from)][caller] >= _value
  require balanceOf[addr(_to)] + _value >= balanceOf[addr(_to)]
  balanceOf[addr(_to)] += _value
  require _value <= balanceOf[addr(_from)]
  balanceOf[addr(_from)] -= _value
  if allowance[addr(_from)][caller] < -1:
      require _value <= allowance[addr(_from)][caller]
      allowance[addr(_from)][caller] -= _value
  log Transfer(
        address from=_value,
        address to=_from,
        uint256 value=_to)
  return 1

