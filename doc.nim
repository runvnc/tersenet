import packages/docutils/rst
import packages/docutils/rstast

proc parse*(rst:string): PRstNode = 
  var opts = {roSupportSmilies}
  var hasToc = false
  result = rstParse(rst,"",0,0,hasToc,opts)
