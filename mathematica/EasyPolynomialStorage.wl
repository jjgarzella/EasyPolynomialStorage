
(* So far this is only copy-pastable *)

WriteSMVpoly[poly_, name_] :=
  Module[{rules, json},
    rules = Association[CoefficientRules[poly]];
    ConvertToJson[key_] := <| "coef" -> ToString[rules[key]], "vars" -> key |>;
    json = Map[ConvertToJson, Keys[rules]];
    Export[name <> ".sMVpoly", json, "JSON"];
  ]

polys = ...
For[i = 1, i <= Length[polys], i++,
  WriteSMVpoly[polys[i], "poly" <> ToString[i]]
]
