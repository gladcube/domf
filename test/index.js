require("LiveScript")
import$(global, require("prelude-ls"))
import$(global, require("glad-functions"))
require("./index.ls")

function import$(obj, src){
  for (var key in src) obj[key] = src[key];
  return obj;
}
