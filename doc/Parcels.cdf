(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 10.0' *)

(*************************************************************************)
(*                                                                       *)
(*  The Mathematica License under which this file was created prohibits  *)
(*  restricting third parties in receipt of this file from republishing  *)
(*  or redistributing it by any means, including but not limited to      *)
(*  rights management or terms of use, without the express consent of    *)
(*  Wolfram Research, Inc. For additional information concerning CDF     *)
(*  licensing and redistribution see:                                    *)
(*                                                                       *)
(*        www.wolfram.com/cdf/adopting-cdf/licensing-options.html        *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1064,         20]
NotebookDataLength[    152758,       4562]
NotebookOptionsPosition[    147438,       4352]
NotebookOutlinePosition[    147860,       4371]
CellTagsIndexPosition[    147817,       4368]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["Parcels", "Title"],

Cell["Gustavo Delfino, 2013-07-08", "Text",
 TextAlignment->Right,
 TextJustification->0.],

Cell[CellGroupData[{

Cell["The Excercise", "Section"],

Cell["\<\
This would be the exercise:

## Find the most efficient combination of 3kg and 5kg parcels required to \
make any shipment of 8kg or more. The app will accept input from a web form.

## Output should either be a simple result view or for bonus points, rendered \
on the same page via AJAX without page refresh. So given 11, output should be:

## 1 five kg parcels, 2 three kg parcels

## Input should be validated.

## Assume at least Ruby 1.9.3 and Rails 3+. Please use TDD and submit your \
answer with either a private github repo or via email.\
\>", "Text"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Manual Procedure", "Section"],

Cell["\<\
These are the manual operations that were made in order to think about a more \
general algorithm:\
\>", "Text"],

Cell["Suppose we want a 99kg shipment:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"num", "=", "99"}]], "Input"],

Cell[BoxData["99"], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"num", "/", "5."}]], "Input"],

Cell[BoxData["19.8`"], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Floor", "[", 
  RowBox[{"num", "/", "5"}], "]"}]], "Input"],

Cell[BoxData["19"], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"5", 
  RowBox[{"Floor", "[", 
   RowBox[{"num", "/", "5"}], "]"}]}]], "Input"],

Cell[BoxData["95"], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"num", "-", 
  RowBox[{"5", 
   RowBox[{"Floor", "[", 
    RowBox[{"num", "/", "5"}], "]"}]}]}]], "Input"],

Cell[BoxData["4"], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Divisible", "[", 
  RowBox[{
   RowBox[{"num", "-", 
    RowBox[{"5", 
     RowBox[{"Floor", "[", 
      RowBox[{"num", "/", "5"}], "]"}]}]}], ",", "3"}], "]"}]], "Input"],

Cell[BoxData["False"], "Output"]
}, Open  ]],

Cell["Now try with one fewer 5kg parsel", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"Floor", "[", 
   RowBox[{"num", "/", "5"}], "]"}], "-", "1"}]], "Input"],

Cell[BoxData["18"], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"5", 
  RowBox[{"(", 
   RowBox[{
    RowBox[{"Floor", "[", 
     RowBox[{"num", "/", "5"}], "]"}], "-", "1"}], ")"}]}]], "Input"],

Cell[BoxData["90"], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"num", "-", 
  RowBox[{"5", 
   RowBox[{"(", 
    RowBox[{
     RowBox[{"Floor", "[", 
      RowBox[{"num", "/", "5"}], "]"}], "-", "1"}], ")"}]}]}]], "Input"],

Cell[BoxData["9"], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Divisible", "[", 
  RowBox[{
   RowBox[{"num", "-", 
    RowBox[{"5", 
     RowBox[{"(", 
      RowBox[{
       RowBox[{"Floor", "[", 
        RowBox[{"num", "/", "5"}], "]"}], "-", "1"}], ")"}]}]}], ",", "3"}], 
  "]"}]], "Input"],

Cell[BoxData["True"], "Output"]
}, Open  ]],

Cell["Now calculate the number of required 3kg parsels:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 FractionBox[
  RowBox[{"num", "-", 
   RowBox[{"5", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{"Floor", "[", 
       RowBox[{"num", "/", "5"}], "]"}], "-", "1"}], ")"}]}]}], "3"]], "Input"],

Cell[BoxData["3"], "Output"]
}, Open  ]],

Cell["Verification:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"18", " ", "5"}], "+", 
  RowBox[{"3", " ", "3"}]}]], "Input"],

Cell[BoxData["99"], "Output"]
}, Open  ]]
}, Closed]],

Cell[CellGroupData[{

Cell["Automating the Search of a Solution", "Section"],

Cell[CellGroupData[{

Cell["Function to calculate the parsels", "Subsection"],

Cell[BoxData[
 RowBox[{
  RowBox[{"parsels", "[", "n_", "]"}], ":=", 
  RowBox[{
   RowBox[{"NestWhile", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"n", "-", 
         RowBox[{"5", 
          RowBox[{"(", 
           RowBox[{
            RowBox[{"\[LeftFloor]", 
             FractionBox["n", "5"], "\[RightFloor]"}], "-", 
            RowBox[{
            "#", "\[LeftDoubleBracket]", "3", "\[RightDoubleBracket]"}]}], 
           ")"}]}]}], ",", 
        RowBox[{"5", 
         RowBox[{"(", 
          RowBox[{
           RowBox[{"\[LeftFloor]", 
            FractionBox["n", "5"], "\[RightFloor]"}], "-", 
           RowBox[{
           "#", "\[LeftDoubleBracket]", "3", "\[RightDoubleBracket]"}]}], 
          ")"}]}], ",", 
        RowBox[{
         RowBox[{"#", "\[LeftDoubleBracket]", "3", "\[RightDoubleBracket]"}], 
         "+", "1"}]}], "}"}], "&"}], ",", 
     RowBox[{"{", 
      RowBox[{"1", ",", "n", ",", "0"}], "}"}], ",", 
     RowBox[{
      RowBox[{"(", 
       RowBox[{"!", 
        RowBox[{"Divisible", "[", 
         RowBox[{
          RowBox[{"#", "\[LeftDoubleBracket]", "1", "\[RightDoubleBracket]"}],
           ",", "3"}], "]"}]}], ")"}], "&"}]}], "]"}], "/.", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"iii_", ",", "v_", ",", "_"}], "}"}], "\[RuleDelayed]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"v", "/", "5"}], ",", 
      RowBox[{"iii", "/", "3"}]}], "}"}]}]}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"parsels", "[", "99", "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"18", ",", "3"}], "}"}]], "Output"]
}, Open  ]]
}, Closed]],

Cell[CellGroupData[{

Cell["Function to pretty print the parsels", "Subsection"],

Cell[BoxData[
 RowBox[{
  RowBox[{"printParsels", "[", 
   RowBox[{"{", 
    RowBox[{"0", ",", "iii_"}], "}"}], "]"}], ":=", 
  RowBox[{"Row", "[", 
   RowBox[{"{", 
    RowBox[{"3", ",", "\"\<\[Times]\>\"", ",", "iii"}], "}"}], 
   "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{
  RowBox[{"printParsels", "[", 
   RowBox[{"{", 
    RowBox[{"v_", ",", "0"}], "}"}], "]"}], ":=", 
  RowBox[{"Row", "[", 
   RowBox[{"{", 
    RowBox[{"5", ",", "\"\<\[Times]\>\"", ",", "v"}], "}"}], "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{
  RowBox[{"printParsels", "[", 
   RowBox[{"{", 
    RowBox[{"v_", ",", "iii_"}], "}"}], "]"}], ":=", 
  RowBox[{"Row", "[", 
   RowBox[{"{", 
    RowBox[{
    "5", ",", "\"\<\[Times]\>\"", ",", "v", ",", "\"\< + \>\"", ",", "3", 
     ",", "\"\<\[Times]\>\"", ",", "iii"}], "}"}], "]"}]}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"printParsels", "[", 
  RowBox[{"parsels", "[", "99", "]"}], "]"}]], "Input"],

Cell[BoxData[
 TemplateBox[{"5","\"\[Times]\"","18","\"+\"","3","\"\[Times]\"","3"},
  "RowDefault"]], "Output"]
}, Open  ]]
}, Closed]],

Cell[CellGroupData[{

Cell["Table of Results", "Subsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"Table", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"n", ",", 
      RowBox[{"printParsels", "[", 
       RowBox[{"parsels", "[", "n", "]"}], "]"}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{"n", ",", "8", ",", "100"}], "}"}]}], "]"}], "//", 
  "TableForm"}]], "Input"],

Cell[BoxData[
 TagBox[GridBox[{
    {"8", 
     TemplateBox[{"5","\"\[Times]\"","1","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"9", 
     TemplateBox[{"3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"10", 
     TemplateBox[{"5","\"\[Times]\"","2"},
      "RowDefault"]},
    {"11", 
     TemplateBox[{"5","\"\[Times]\"","1","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"12", 
     TemplateBox[{"3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"13", 
     TemplateBox[{"5","\"\[Times]\"","2","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"14", 
     TemplateBox[{"5","\"\[Times]\"","1","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"15", 
     TemplateBox[{"5","\"\[Times]\"","3"},
      "RowDefault"]},
    {"16", 
     TemplateBox[{"5","\"\[Times]\"","2","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"17", 
     TemplateBox[{"5","\"\[Times]\"","1","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"18", 
     TemplateBox[{"5","\"\[Times]\"","3","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"19", 
     TemplateBox[{"5","\"\[Times]\"","2","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"20", 
     TemplateBox[{"5","\"\[Times]\"","4"},
      "RowDefault"]},
    {"21", 
     TemplateBox[{"5","\"\[Times]\"","3","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"22", 
     TemplateBox[{"5","\"\[Times]\"","2","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"23", 
     TemplateBox[{"5","\"\[Times]\"","4","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"24", 
     TemplateBox[{"5","\"\[Times]\"","3","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"25", 
     TemplateBox[{"5","\"\[Times]\"","5"},
      "RowDefault"]},
    {"26", 
     TemplateBox[{"5","\"\[Times]\"","4","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"27", 
     TemplateBox[{"5","\"\[Times]\"","3","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"28", 
     TemplateBox[{"5","\"\[Times]\"","5","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"29", 
     TemplateBox[{"5","\"\[Times]\"","4","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"30", 
     TemplateBox[{"5","\"\[Times]\"","6"},
      "RowDefault"]},
    {"31", 
     TemplateBox[{"5","\"\[Times]\"","5","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"32", 
     TemplateBox[{"5","\"\[Times]\"","4","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"33", 
     TemplateBox[{"5","\"\[Times]\"","6","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"34", 
     TemplateBox[{"5","\"\[Times]\"","5","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"35", 
     TemplateBox[{"5","\"\[Times]\"","7"},
      "RowDefault"]},
    {"36", 
     TemplateBox[{"5","\"\[Times]\"","6","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"37", 
     TemplateBox[{"5","\"\[Times]\"","5","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"38", 
     TemplateBox[{"5","\"\[Times]\"","7","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"39", 
     TemplateBox[{"5","\"\[Times]\"","6","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"40", 
     TemplateBox[{"5","\"\[Times]\"","8"},
      "RowDefault"]},
    {"41", 
     TemplateBox[{"5","\"\[Times]\"","7","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"42", 
     TemplateBox[{"5","\"\[Times]\"","6","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"43", 
     TemplateBox[{"5","\"\[Times]\"","8","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"44", 
     TemplateBox[{"5","\"\[Times]\"","7","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"45", 
     TemplateBox[{"5","\"\[Times]\"","9"},
      "RowDefault"]},
    {"46", 
     TemplateBox[{"5","\"\[Times]\"","8","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"47", 
     TemplateBox[{"5","\"\[Times]\"","7","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"48", 
     TemplateBox[{"5","\"\[Times]\"","9","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"49", 
     TemplateBox[{"5","\"\[Times]\"","8","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"50", 
     TemplateBox[{"5","\"\[Times]\"","10"},
      "RowDefault"]},
    {"51", 
     TemplateBox[{"5","\"\[Times]\"","9","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"52", 
     TemplateBox[{"5","\"\[Times]\"","8","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"53", 
     TemplateBox[{"5","\"\[Times]\"","10","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"54", 
     TemplateBox[{"5","\"\[Times]\"","9","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"55", 
     TemplateBox[{"5","\"\[Times]\"","11"},
      "RowDefault"]},
    {"56", 
     TemplateBox[{"5","\"\[Times]\"","10","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"57", 
     TemplateBox[{"5","\"\[Times]\"","9","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"58", 
     TemplateBox[{"5","\"\[Times]\"","11","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"59", 
     TemplateBox[{"5","\"\[Times]\"","10","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"60", 
     TemplateBox[{"5","\"\[Times]\"","12"},
      "RowDefault"]},
    {"61", 
     TemplateBox[{"5","\"\[Times]\"","11","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"62", 
     TemplateBox[{"5","\"\[Times]\"","10","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"63", 
     TemplateBox[{"5","\"\[Times]\"","12","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"64", 
     TemplateBox[{"5","\"\[Times]\"","11","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"65", 
     TemplateBox[{"5","\"\[Times]\"","13"},
      "RowDefault"]},
    {"66", 
     TemplateBox[{"5","\"\[Times]\"","12","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"67", 
     TemplateBox[{"5","\"\[Times]\"","11","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"68", 
     TemplateBox[{"5","\"\[Times]\"","13","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"69", 
     TemplateBox[{"5","\"\[Times]\"","12","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"70", 
     TemplateBox[{"5","\"\[Times]\"","14"},
      "RowDefault"]},
    {"71", 
     TemplateBox[{"5","\"\[Times]\"","13","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"72", 
     TemplateBox[{"5","\"\[Times]\"","12","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"73", 
     TemplateBox[{"5","\"\[Times]\"","14","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"74", 
     TemplateBox[{"5","\"\[Times]\"","13","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"75", 
     TemplateBox[{"5","\"\[Times]\"","15"},
      "RowDefault"]},
    {"76", 
     TemplateBox[{"5","\"\[Times]\"","14","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"77", 
     TemplateBox[{"5","\"\[Times]\"","13","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"78", 
     TemplateBox[{"5","\"\[Times]\"","15","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"79", 
     TemplateBox[{"5","\"\[Times]\"","14","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"80", 
     TemplateBox[{"5","\"\[Times]\"","16"},
      "RowDefault"]},
    {"81", 
     TemplateBox[{"5","\"\[Times]\"","15","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"82", 
     TemplateBox[{"5","\"\[Times]\"","14","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"83", 
     TemplateBox[{"5","\"\[Times]\"","16","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"84", 
     TemplateBox[{"5","\"\[Times]\"","15","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"85", 
     TemplateBox[{"5","\"\[Times]\"","17"},
      "RowDefault"]},
    {"86", 
     TemplateBox[{"5","\"\[Times]\"","16","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"87", 
     TemplateBox[{"5","\"\[Times]\"","15","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"88", 
     TemplateBox[{"5","\"\[Times]\"","17","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"89", 
     TemplateBox[{"5","\"\[Times]\"","16","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"90", 
     TemplateBox[{"5","\"\[Times]\"","18"},
      "RowDefault"]},
    {"91", 
     TemplateBox[{"5","\"\[Times]\"","17","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"92", 
     TemplateBox[{"5","\"\[Times]\"","16","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"93", 
     TemplateBox[{"5","\"\[Times]\"","18","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"94", 
     TemplateBox[{"5","\"\[Times]\"","17","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"95", 
     TemplateBox[{"5","\"\[Times]\"","19"},
      "RowDefault"]},
    {"96", 
     TemplateBox[{"5","\"\[Times]\"","18","\" + \"","3","\"\[Times]\"","2"},
      "RowDefault"]},
    {"97", 
     TemplateBox[{"5","\"\[Times]\"","17","\" + \"","3","\"\[Times]\"","4"},
      "RowDefault"]},
    {"98", 
     TemplateBox[{"5","\"\[Times]\"","19","\" + \"","3","\"\[Times]\"","1"},
      "RowDefault"]},
    {"99", 
     TemplateBox[{"5","\"\[Times]\"","18","\" + \"","3","\"\[Times]\"","3"},
      "RowDefault"]},
    {"100", 
     TemplateBox[{"5","\"\[Times]\"","20"},
      "RowDefault"]}
   },
   GridBoxAlignment->{
    "Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
     "RowsIndexed" -> {}},
   GridBoxSpacings->{"Columns" -> {
       Offset[0.27999999999999997`], {
        Offset[2.0999999999999996`]}, 
       Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
       Offset[0.2], {
        Offset[0.4]}, 
       Offset[0.2]}, "RowsIndexed" -> {}}],
  Function[BoxForm`e$, 
   TableForm[BoxForm`e$]]]], "Output"]
}, Open  ]]
}, Closed]],

Cell[CellGroupData[{

Cell["10000 Tests !", "Subsection"],

Cell["Test from 8kg to 10000kg", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"And", "@@", 
  RowBox[{"Table", "[", 
   RowBox[{
    RowBox[{"n", "==", 
     RowBox[{
      RowBox[{"5", 
       RowBox[{
        RowBox[{"parsels", "[", "n", "]"}], "\[LeftDoubleBracket]", "1", 
        "\[RightDoubleBracket]"}]}], "+", 
      RowBox[{"3", 
       RowBox[{
        RowBox[{"parsels", "[", "n", "]"}], "\[LeftDoubleBracket]", "2", 
        "\[RightDoubleBracket]"}]}]}]}], ",", 
    RowBox[{"{", 
     RowBox[{"n", ",", "8", ",", "10000"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData["True"], "Output"]
}, Open  ]]
}, Closed]],

Cell[CellGroupData[{

Cell["Plots", "Subsection"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"GraphicsGrid", "[", "\[IndentingNewLine]", 
  RowBox[{"{", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"Table", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"n", ",", 
             RowBox[{
              RowBox[{"parsels", "[", "n", "]"}], "[", 
              RowBox[{"[", "1", "]"}], "]"}]}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{"n", ",", "8", ",", "100"}], "}"}]}], "]"}], "}"}], ",", 
        RowBox[{"PlotLabel", "\[Rule]", "\"\<5kg parsels\>\""}]}], "]"}], ",",
       "\[IndentingNewLine]", 
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"Table", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"n", ",", 
             RowBox[{
              RowBox[{"parsels", "[", "n", "]"}], "[", 
              RowBox[{"[", "2", "]"}], "]"}]}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{"n", ",", "8", ",", "100"}], "}"}]}], "]"}], "}"}], ",", 
        RowBox[{"PlotLabel", "\[Rule]", "\"\<3kg parsels\>\""}]}], "]"}]}], 
     "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"Table", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"n", ",", 
             RowBox[{
              RowBox[{"parsels", "[", "n", "]"}], "[", 
              RowBox[{"[", "1", "]"}], "]"}]}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{"n", ",", "8", ",", "100"}], "}"}]}], "]"}], "}"}], ",", 
        RowBox[{"Joined", "\[Rule]", "True"}]}], "]"}], ",", 
      "\[IndentingNewLine]", 
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"Table", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"n", ",", 
             RowBox[{
              RowBox[{"parsels", "[", "n", "]"}], "[", 
              RowBox[{"[", "2", "]"}], "]"}]}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{"n", ",", "8", ",", "100"}], "}"}]}], "]"}], "}"}], ",", 
        RowBox[{"Joined", "\[Rule]", "True"}]}], "]"}]}], "}"}]}], "}"}], 
  "]"}]], "Input"],

Cell[BoxData[
 GraphicsBox[{{}, {{InsetBox[
      GraphicsBox[{{}, {{}, 
         {RGBColor[0.24720000000000014`, 0.24, 0.6], PointBox[CompressedData["

1:eJxd1LtKA1EQBuDBytLCwsJCg4iIiNF4v2TMPTHX3U12LWwEa19hHu08ko+g
sjPF/x9Yfn74GLY4cw4/v7OvLRH5+Pv+sz4HWudPu86GCpyj6J7H5E/In5I/
I3/ufdvzgnyT/CX5K/Itzx3Pa/I35G/J35G/99z1fCD/SP6J/DP5F889zzZ5
RW9K/hW9Rd/37KC3Dnrporcueul5+j2wHnrp0/w+ehnQ/OgNzyHNH6KXEXob
oZexp99DG6OXCc2foJc3mh897vGU5k/Rywy9zdDL3NP3wOboZUHzF+hliV6j
+x7ZEn0iLyv0ukJv0X0PE3nJ0GuG3jL0KXrscY5ec/SWo0/kpfD0d0AL9Fag
T+RljV6j+ztia/SJvGzQ6wa9Rfd3KJGXkv6/RG8l+hQ93rEKvVborUKfyMu7
Z0t/AcKVbk8=
           "]]}, {}}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       Frame->{{False, False}, {False, False}},
       FrameLabel->{{None, None}, {None, None}},
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       Method->{"ScalingFunctions" -> None},
       PlotLabel->FormBox["\"5kg parsels\"", TraditionalForm],
       PlotRange->{{0, 100.}, {0, 20.}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.02]}},
       Ticks->{Automatic, Automatic}], {192., -118.66252583997979`}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, 
         {RGBColor[0.24720000000000014`, 0.24, 0.6], PointBox[CompressedData["

1:eJxdkElKBUEQRBtXLj2CioiIiPOsP/3Os37nhRvBtVeoo9WRPIJKxyvICGiC
t+hHVE59fo++xrqu+/j7/rvPZPT9M+h7WjyunokuZRZWz6kn1PPmWzDfovmW
zLdsvhXzrZpvzXzr5tsw36b5tsy3bb4d8+2ab898++Y7MN/AfJF9BcZ3mH0F
JsPsKzD7jrKvwOw7zr7SWH1i+2D2ndo+mJzZPph957YPZt+F7WusvrR9MPuu
bB9Mrm0fzL4b2wez79b2NVbf2T6YfffZFzC+xn1XmH0P2Rcw74WV2lg9yr6A
eS8sX4XJY/YFzHth+SrM/Z6yLxrrf1i+CnO/5+wLWCmN9T/M/V6yL2DuByu1
sfo1+wLmfjD3g8lb9gXM/WDuB3O/9+b7Bek1bok=
           "]]}, {}}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       Frame->{{False, False}, {False, False}},
       FrameLabel->{{None, None}, {None, None}},
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       Method->{"ScalingFunctions" -> None},
       PlotLabel->FormBox["\"3kg parsels\"", TraditionalForm],
       PlotRange->{{0, 100.}, {0, 4.}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.02]}},
       Ticks->{Automatic, Automatic}], {576., -118.66252583997979`}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}]}, {InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.24720000000000014`, 0.24, 0.6], LineBox[CompressedData["
1:eJxd1LtKA1EQBuDBytLCwsJCg4iIiNF4v2TMPTHX3U12LWwEa19hHu08ko+g
sjPF/x9Yfn74GLY4cw4/v7OvLRH5+Pv+sz4HWudPu86GCpyj6J7H5E/In5I/
I3/ufdvzgnyT/CX5K/Itzx3Pa/I35G/J35G/99z1fCD/SP6J/DP5F889zzZ5
RW9K/hW9Rd/37KC3Dnrporcueul5+j2wHnrp0/w+ehnQ/OgNzyHNH6KXEXob
oZexp99DG6OXCc2foJc3mh897vGU5k/Rywy9zdDL3NP3wOboZUHzF+hliV6j
+x7ZEn0iLyv0ukJv0X0PE3nJ0GuG3jL0KXrscY5ec/SWo0/kpfD0d0AL9Fag
T+RljV6j+ztia/SJvGzQ6wa9Rfd3KJGXkv6/RG8l+hQ93rEKvVborUKfyMu7
Z0t/AcKVbk8=
           "]]}}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       Frame->{{False, False}, {False, False}},
       FrameLabel->{{None, None}, {None, None}},
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       Method->{"ScalingFunctions" -> None},
       PlotRange->{{0, 100.}, {0, 20.}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.02]}},
       Ticks->{Automatic, Automatic}], {192., -355.98757751993935`}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.24720000000000014`, 0.24, 0.6], LineBox[CompressedData["
1:eJxdkElKBUEQRBtXLj2CioiIiPOsP/3Os37nhRvBtVeoo9WRPIJKxyvICGiC
t+hHVE59fo++xrqu+/j7/rvPZPT9M+h7WjyunokuZRZWz6kn1PPmWzDfovmW
zLdsvhXzrZpvzXzr5tsw36b5tsy3bb4d8+2ab898++Y7MN/AfJF9BcZ3mH0F
JsPsKzD7jrKvwOw7zr7SWH1i+2D2ndo+mJzZPph957YPZt+F7WusvrR9MPuu
bB9Mrm0fzL4b2wez79b2NVbf2T6YfffZFzC+xn1XmH0P2Rcw74WV2lg9yr6A
eS8sX4XJY/YFzHth+SrM/Z6yLxrrf1i+CnO/5+wLWCmN9T/M/V6yL2DuByu1
sfo1+wLmfjD3g8lb9gXM/WDuB3O/9+b7Bek1bok=
           "]]}}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       Frame->{{False, False}, {False, False}},
       FrameLabel->{{None, None}, {None, None}},
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       Method->{"ScalingFunctions" -> None},
       PlotRange->{{0, 100.}, {0, 4.}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.02]}},
       Ticks->{Automatic, Automatic}], {576., -355.98757751993935`}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}]}}, {}},
  ContentSelectable->True,
  ImageSize->{677.21875, Automatic},
  PlotRangePadding->{6, 5}]], "Output"]
}, Open  ]]
}, Closed]]
}, Closed]],

Cell[CellGroupData[{

Cell["Iteration Free Algorithm", "Section"],

Cell[BoxData[
 GraphicsBox[
  TagBox[RasterBox[CompressedData["
1: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
fcOvpn9iPjVZiQb7AENuwwttRGVWlxO3Dif+quUMdw+VikFbM9mewB0x2lmt
z2WE5EuuWg5z1gjzFZLECHa7fMgaYhNK89kzyU9YfyCyChLZ7e+/KarVt2r7
XtZYCBsTMdEqrcryR3IkZx0prCVJTIUeXNNjXyvec2x6ZSzuw0NClaRL663J
0EY2hdBGtT8wVHUDQJPatjG8uoydmAFLcXfvsNMZEU/1dXkQE0V1HwKBFfbZ
Gl4I9aYnLwW1f0kw2cX5/IOiW7TGnN8JGWx8C7ljrdCGK4O7W4ltemavnLGl
mSHPmLiC1yWIYLfHo6lS9XPU6/rq6bREgVXtNUD/3Vb+qvuyWl715G0F4rtn
DRi2qjFLBqbachZLVre0gnmRFYG2wawzcl+Yimv79TUbqCUlqAs9RYR3yDqR
mdSjXGOxgIWXbNEuL+KKigeIxr7hPTeu2MjVIz5aeYkJHWJ9heogu6+h5xIe
VtDMi2ZGSwN2acmZT7TrJiW8UVivYSPZyIxmeLUjhW4EWbO691QYXl0kBYEz
uRSMdA5q160ptq4FeiA52UgrZcFkx3nhM7u9JjuC4HW1C1IJPZAJp+ccxocQ
qGCzMyTZqTIjA89sF12R7D2MXIMrtkO9y/DG7ZRL0O0JD8EA6V4YJ3DCJeZO
Wrw07vYiAYB+HojHsQHgrwZauK0+TAWWUMFFveYHdnl2ANBxJoRRfvm9Lf/a
oZYAAAAAAAAAAAAAAAAAAHgQGGoTuW/lboRinrf2tybOXs5Ju9zSE9/R+aoj
OATGp8kdLO9xc/wNifdCN5kF7+7616SxO1Nj3tINm9B1WCX9dJP+T6zGjcoW
k5ylZs73vwUZ5kZk7t2fnbE/29/1/riO50omO1uO0qhz/8LGa79+/cb9bAgA
AAxmpstXt1Iq78iv0lvStL5KCz5Po+Pyq39uSunEHKfsqaRper+zg/qgqfu+
korPw/Xen4xwVFTTqn8tv3yeyByfmlFJ3z3jYnL/RGbVl3XVNyoWczl6zYu8
FZBOM/jFKazevf/tGFJwuYXUS8Xu9Z2Y7EKb9SXeO9F1nXxngergMMsNtez1
phbNWaI+f82XV2/Sn/i3MeVJnC1OprxRtMnSos0mM5H+sDaDVtdtuMN9bGUA
eCjZGlhFh2hKusmyEzuqr/uGdH52I/2iYmMs+cPW1L0YyVTa8jZ+OC32m6JC
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
0NNV
    "], {{0, 103}, {506, 0}}, {0, 255},
    ColorFunction->RGBColor],
   BoxForm`ImageTag["Byte", ColorSpace -> "RGB", Interleaving -> True],
   Selectable->False],
  BaseStyle->"ImageGraphics",
  ImageSize->Magnification[1.],
  ImageSizeRaw->{506, 103},
  PlotRange->{{0, 506}, {0, 103}}]], "Input"],

Cell[CellGroupData[{

Cell["3kg Units", "Subsection"],

Cell["These are the first few terms of the 3kg sequence:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Table", "[", 
  RowBox[{
   RowBox[{
    RowBox[{"parsels", "[", "n", "]"}], "\[LeftDoubleBracket]", "2", 
    "\[RightDoubleBracket]"}], ",", 
   RowBox[{"{", 
    RowBox[{"n", ",", "8", ",", "20"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
  "1", ",", "3", ",", "0", ",", "2", ",", "4", ",", "1", ",", "3", ",", "0", 
   ",", "2", ",", "4", ",", "1", ",", "3", ",", "0"}], "}"}]], "Output"]
}, Open  ]],

Cell[TextData[{
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " finds the generating function directly!"
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"FindSequenceFunction", "[", "%", "]"}]], "Input"],

Cell[BoxData[
 RowBox[{
  RowBox[{"Mod", "[", 
   RowBox[{
    RowBox[{"4", "+", 
     RowBox[{"2", " ", "#1"}]}], ",", "5"}], "]"}], "&"}]], "Output",
 Background->RGBColor[0.88, 1, 0.88]]
}, Open  ]],

Cell["\<\
As a verification we will plot this function over the original function with \
an offset of 1:\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ListPlot", "[", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{
        RowBox[{
         RowBox[{"parsels", "[", "n", "]"}], "[", 
         RowBox[{"[", "2", "]"}], "]"}], "+", "1"}], ",", 
       RowBox[{"{", 
        RowBox[{"n", ",", "8", ",", "100"}], "}"}]}], "]"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{
        RowBox[{
         RowBox[{"Mod", "[", 
          RowBox[{
           RowBox[{
            RowBox[{"2", "#"}], "-", "10"}], ",", "5"}], "]"}], "&"}], "[", 
        "n", "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"n", ",", "8", ",", "100"}], "}"}]}], "]"}]}], "}"}], ",", 
   RowBox[{"Joined", "\[Rule]", "True"}], ",", 
   RowBox[{"AspectRatio", "\[Rule]", 
    RowBox[{"1", "/", "10"}]}]}], "]"}]], "Input"],

Cell[BoxData[
 GraphicsBox[{{}, {{}, {}, 
    {RGBColor[0.24720000000000014`, 0.24, 0.6], LineBox[CompressedData["
1:eJxdkTlKREEYBh9GhgYGBgYqIiIi7ru+333fxi0yEYy9Qh+tjzRHULEr+Gtg
6KnHo6j+Zvrze/A10nXdx+/37/z/DPv2I/I51s7RyO/5+bjOCXkm5ZuSb0a+
Wfnm5JuXb0G+RfmW5FuWb0W+VfnW5FuXb0O+Tfm25NuWb0e+Xfn25NuX70C+
Q/l6+SL7CozvKPsKjO84+wpM30n2FZi+0+wrMH1n6oPpO1cfTN+F+mD6LtUH
03elPpi+a/XB9N2oD6bvVn0wfXfqg+m7Vx9M34P6YPoesy9gfHDzVZi+p+wL
mPvCzVdh+gbZFzD3hZuvwuz3nH0Bc1+4+SrMfi/ZFzD/B9x8FWa/1+wLmP1g
9oPZ7y37AmY/mP1g9nvPvoCH/Q8GEnDh
      "]]}, 
    {RGBColor[0.6, 0.24, 0.4428931686004542], LineBox[CompressedData["
1:eJxdkblKRFEQBS9GhgYGBgYqIiIi47477bjvOm6RiWDsL9xPe5/kJ6hM14Vz
GoamhnlFvZ7Zz+/h11gp5ePv879H89PXXWK0xm0zE6G/mwz9firUN22eGfPN
mW/efAvmWzTfkvmWzbdivp75Vs23Zr51822Yb9N8W+bbNt+O+XbNt2e+ffMd
mO/QfEfm65sv1Fdh5lh9FcY3UF+F6TtRX22c+1R9FabvzPpg5tz6YPourA+m
79L6Gue+sj6Yvmvrg5kb64Ppu7U+mL4762uc+976YPoerA9mHtUXMD44fR1M
35P6onE+D6evg+kbqi/gnNo4n4e537P6AuZ94Zyuce4X9QXM/wGnr4OZV/UF
zP1g7gdzvzf1ReN8HuZ+MPd7V1/ApfwCtOJqsQ==
      "]]}}, {}},
  AspectRatio->NCache[
    Rational[1, 10], 0.1],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, 0},
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  ImageSize->{1314.99609375, Automatic},
  Method->{"ScalingFunctions" -> None},
  PlotRange->{{0, 93.}, {0, 5.}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.02]}},
  Ticks->{Automatic, Automatic}]], "Output"]
}, Open  ]]
}, Closed]],

Cell[CellGroupData[{

Cell["5kg Units", "Subsection"],

Cell["These are the first few terms of the 5kg sequence:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Table", "[", 
  RowBox[{
   RowBox[{
    RowBox[{"parsels", "[", "n", "]"}], "\[LeftDoubleBracket]", "1", 
    "\[RightDoubleBracket]"}], ",", 
   RowBox[{"{", 
    RowBox[{"n", ",", "8", ",", "20"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
  "1", ",", "0", ",", "2", ",", "1", ",", "0", ",", "2", ",", "1", ",", "3", 
   ",", "2", ",", "1", ",", "3", ",", "2", ",", "4"}], "}"}]], "Output"]
}, Open  ]],

Cell[TextData[{
 "This time we are not so lucky as ",
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " can\[CloseCurlyQuote]t find a simple closed for solution for our sequence. \
But we can with a little work."
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"FindSequenceFunction", "[", "%", "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"DifferenceRoot", "[", 
  RowBox[{"Function", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"\[FormalY]", ",", "\[FormalN]"}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       RowBox[{
        RowBox[{"-", "1"}], "-", 
        RowBox[{"\[FormalY]", "[", "\[FormalN]", "]"}], "+", 
        RowBox[{"\[FormalY]", "[", 
         RowBox[{"5", "+", "\[FormalN]"}], "]"}]}], "\[Equal]", "0"}], ",", 
      RowBox[{
       RowBox[{"\[FormalY]", "[", "1", "]"}], "\[Equal]", "1"}], ",", 
      RowBox[{
       RowBox[{"\[FormalY]", "[", "2", "]"}], "\[Equal]", "0"}], ",", 
      RowBox[{
       RowBox[{"\[FormalY]", "[", "3", "]"}], "\[Equal]", "2"}], ",", 
      RowBox[{
       RowBox[{"\[FormalY]", "[", "4", "]"}], "\[Equal]", "1"}], ",", 
      RowBox[{
       RowBox[{"\[FormalY]", "[", "5", "]"}], "\[Equal]", "0"}]}], "}"}]}], 
   "]"}], "]"}]], "Output"]
}, Open  ]],

Cell[TextData[{
 "Lets remove the slope from this sequence by substracting ",
 Cell[BoxData[
  FormBox[
   RowBox[{"n", "/", "5"}], TraditionalForm]]],
 " from it:"
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ListPlot", "[", 
  RowBox[{
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"n", ",", 
       RowBox[{
        RowBox[{
         RowBox[{"parsels", "[", "n", "]"}], "\[LeftDoubleBracket]", "1", 
         "\[RightDoubleBracket]"}], "-", 
        RowBox[{"n", "/", "5"}]}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"n", ",", "8", ",", "100"}], "}"}]}], "]"}], ",", 
   RowBox[{"Joined", "\[Rule]", "True"}], ",", 
   RowBox[{"AspectRatio", "\[Rule]", 
    RowBox[{"1", "/", "10"}]}]}], "]"}]], "Input"],

Cell[BoxData[
 GraphicsBox[{{}, {{}, {}, 
    {RGBColor[0.24720000000000014`, 0.24, 0.6], LineBox[CompressedData["
1:eJxd0UtqAkEURuEm2UgiQSQE0WjMU72+39pd/XTgRHDsFmpnqQUkq8gSnGaQ
mG4C9xSIFC0fp3+v90dzuPA8b/f7OX/n50oaf+frPb+X5PPjfL6L+4146pSL
35+K55Xifuny+y28O3hVeDV4dXj38BrwmvAe4LXgPcJ7gvcM7wXeK7w3eG14
HXhdeKI9K/B62rM9eH3t2T76BtqzA/QNtWeH6Buhb4S+MfrG6Jugb4K+Kfqm
6Juhb4a+Ofrm6Fugb4G+JfqW6Fuhb4W+NfrW6Nugb4M+X3viw/O153z0BdqT
AO8baM8F6DPaE4P3NdpzBvuF2pMQ7xtqz4XYL9KeRPg/Iu25CPvF2C/GfjH2
i7Ffgv0S7JdgvwT7pdgvxX4p9kuxX4b9MuyXYb8M+23/vR984FFt
      "]]}}, {}},
  AspectRatio->NCache[
    Rational[1, 10], 0.1],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, 0},
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  ImageSize->{952.56640625, Automatic},
  Method->{"ScalingFunctions" -> None},
  PlotRange->{{0, 100.}, {-2.4, 0}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.02]}},
  Ticks->{Automatic, Automatic}]], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Table", "[", 
  RowBox[{
   RowBox[{
    RowBox[{
     RowBox[{"parsels", "[", "n", "]"}], "\[LeftDoubleBracket]", "1", 
     "\[RightDoubleBracket]"}], "-", 
    RowBox[{"n", "/", "5"}]}], ",", 
   RowBox[{"{", 
    RowBox[{"n", ",", "8", ",", "50"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0"}], "}"}]], "Output"]
}, Open  ]],

Cell[TextData[{
 StyleBox["Mathematica",
  FontSlant->"Italic"],
 " now can find the generating function, but it is too complicated..."
}], "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"FindSequenceFunction", "[", "%", "]"}], "//", 
  "Simplify"}]], "Input"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"-", 
    FractionBox["6", "5"]}], "-", 
   RowBox[{
    FractionBox["12", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["2", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "5"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["12", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["4", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "5"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["12", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["6", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "5"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["12", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["8", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "5"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["6", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["2", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "4"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["6", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["4", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "4"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["6", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["6", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "4"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["6", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["8", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "4"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["9", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["2", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "2"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["9", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["4", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "2"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["9", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["6", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "2"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["9", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["8", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "2"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["3", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["2", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "1"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["3", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["4", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "1"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["3", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["6", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "1"}], "+", "#1"}], ")"}]}], "]"}]}], "-", 
   RowBox[{
    FractionBox["3", "25"], " ", 
    RowBox[{"Cos", "[", 
     RowBox[{
      FractionBox["8", "5"], " ", "\[Pi]", " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "1"}], "+", "#1"}], ")"}]}], "]"}]}]}], "&"}]], "Output"]
}, Open  ]],

Cell["\<\
The linearized sequence is greatly simplified by multiplicating it by 5:\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"5", 
  RowBox[{"Table", "[", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{"parsels", "[", "n", "]"}], "\[LeftDoubleBracket]", "1", 
      "\[RightDoubleBracket]"}], "-", 
     RowBox[{"n", "/", "5"}]}], ",", 
    RowBox[{"{", 
     RowBox[{"n", ",", "8", ",", "50"}], "}"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0"}], "}"}]], "Output"]
}, Open  ]],

Cell["And this is just a repeating pattern:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Table", "[", 
  RowBox[{
   RowBox[{"First", "[", 
    RowBox[{"RotateLeft", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"-", "3"}], ",", 
        RowBox[{"-", "9"}], ",", "0", ",", 
        RowBox[{"-", "6"}], ",", 
        RowBox[{"-", "12"}]}], "}"}], ",", 
      RowBox[{"n", "-", "8"}]}], "]"}], "]"}], ",", 
   RowBox[{"{", 
    RowBox[{"n", ",", "8", ",", "50"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0", ",", 
   RowBox[{"-", "6"}], ",", 
   RowBox[{"-", "12"}], ",", 
   RowBox[{"-", "3"}], ",", 
   RowBox[{"-", "9"}], ",", "0"}], "}"}]], "Output"]
}, Open  ]],

Cell["Reversing the transformations:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Table", "[", 
  RowBox[{
   FractionBox[
    RowBox[{"First", "[", 
     RowBox[{"RotateLeft", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"-", "3"}], ",", 
         RowBox[{"-", "9"}], ",", "0", ",", 
         RowBox[{"-", "6"}], ",", 
         RowBox[{"-", "12"}]}], "}"}], ",", 
       RowBox[{"n", "-", "8"}]}], "]"}], "]"}], "5"], ",", 
   RowBox[{"{", 
    RowBox[{"n", ",", "8", ",", "50"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0", ",", 
   RowBox[{"-", 
    FractionBox["6", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["12", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["3", "5"]}], ",", 
   RowBox[{"-", 
    FractionBox["9", "5"]}], ",", "0"}], "}"}]], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Table", "[", 
  RowBox[{
   FractionBox[
    RowBox[{
     RowBox[{"First", "[", 
      RowBox[{"RotateLeft", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"-", "3"}], ",", 
          RowBox[{"-", "9"}], ",", "0", ",", 
          RowBox[{"-", "6"}], ",", 
          RowBox[{"-", "12"}]}], "}"}], ",", 
        RowBox[{"n", "-", "8"}]}], "]"}], "]"}], "+", "n"}], "5"], ",", 
   RowBox[{"{", 
    RowBox[{"n", ",", "8", ",", "50"}], "}"}]}], "]"}]], "Input",
 Background->RGBColor[0.88, 1, 0.88]],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
  "1", ",", "0", ",", "2", ",", "1", ",", "0", ",", "2", ",", "1", ",", "3", 
   ",", "2", ",", "1", ",", "3", ",", "2", ",", "4", ",", "3", ",", "2", ",", 
   "4", ",", "3", ",", "5", ",", "4", ",", "3", ",", "5", ",", "4", ",", "6", 
   ",", "5", ",", "4", ",", "6", ",", "5", ",", "7", ",", "6", ",", "5", ",", 
   "7", ",", "6", ",", "8", ",", "7", ",", "6", ",", "8", ",", "7", ",", "9", 
   ",", "8", ",", "7", ",", "9", ",", "8", ",", "10"}], "}"}]], "Output"]
}, Open  ]],

Cell["And this matches the original iterative function:", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Table", "[", 
  RowBox[{
   RowBox[{
    RowBox[{"parsels", "[", "n", "]"}], "\[LeftDoubleBracket]", "1", 
    "\[RightDoubleBracket]"}], ",", 
   RowBox[{"{", 
    RowBox[{"n", ",", "8", ",", "50"}], "}"}]}], "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
  "1", ",", "0", ",", "2", ",", "1", ",", "0", ",", "2", ",", "1", ",", "3", 
   ",", "2", ",", "1", ",", "3", ",", "2", ",", "4", ",", "3", ",", "2", ",", 
   "4", ",", "3", ",", "5", ",", "4", ",", "3", ",", "5", ",", "4", ",", "6", 
   ",", "5", ",", "4", ",", "6", ",", "5", ",", "7", ",", "6", ",", "5", ",", 
   "7", ",", "6", ",", "8", ",", "7", ",", "6", ",", "8", ",", "7", ",", "9", 
   ",", "8", ",", "7", ",", "9", ",", "8", ",", "10"}], "}"}]], "Output"]
}, Open  ]]
}, Closed]]
}, Closed]],

Cell[CellGroupData[{

Cell["Combinations", "Section"],

Cell[BoxData[
 RowBox[{
  RowBox[{"d", "=", 
   RowBox[{"Flatten", "[", 
    RowBox[{
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"a", ",", "b", ",", 
         RowBox[{
          RowBox[{"3", "a"}], "+", 
          RowBox[{"5", "b"}]}]}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{"a", ",", "1", ",", "5", ",", 
         RowBox[{"1", "/", "10"}]}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{"b", ",", "1", ",", "5", ",", 
         RowBox[{"1", "/", "10"}]}], "}"}]}], "]"}], ",", "1"}], "]"}]}], 
  ";"}]], "Input"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Cases", "[", 
  RowBox[{"d", ",", 
   RowBox[{"{", 
    RowBox[{"_Rational", ",", "_Rational", ",", "_Integer"}], "}"}]}], 
  "]"}]], "Input"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["11", "10"], ",", "10"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["13", "10"], ",", "11"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["3", "2"], ",", "12"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["17", "10"], ",", "13"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["19", "10"], ",", "14"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["21", "10"], ",", "15"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["23", "10"], ",", "16"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["5", "2"], ",", "17"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["27", "10"], ",", "18"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["29", "10"], ",", "19"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["31", "10"], ",", "20"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["33", "10"], ",", "21"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["7", "2"], ",", "22"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["37", "10"], ",", "23"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["39", "10"], ",", "24"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["41", "10"], ",", "25"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["43", "10"], ",", "26"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["9", "2"], ",", "27"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["47", "10"], ",", "28"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["3", "2"], ",", 
     FractionBox["49", "10"], ",", "29"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["11", "10"], ",", "13"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["13", "10"], ",", "14"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["3", "2"], ",", "15"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["17", "10"], ",", "16"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["19", "10"], ",", "17"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["21", "10"], ",", "18"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["23", "10"], ",", "19"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["5", "2"], ",", "20"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["27", "10"], ",", "21"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["29", "10"], ",", "22"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["31", "10"], ",", "23"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["33", "10"], ",", "24"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["7", "2"], ",", "25"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["37", "10"], ",", "26"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["39", "10"], ",", "27"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["41", "10"], ",", "28"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["43", "10"], ",", "29"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["9", "2"], ",", "30"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["47", "10"], ",", "31"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["5", "2"], ",", 
     FractionBox["49", "10"], ",", "32"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["11", "10"], ",", "16"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["13", "10"], ",", "17"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["3", "2"], ",", "18"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["17", "10"], ",", "19"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["19", "10"], ",", "20"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["21", "10"], ",", "21"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["23", "10"], ",", "22"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["5", "2"], ",", "23"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["27", "10"], ",", "24"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["29", "10"], ",", "25"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["31", "10"], ",", "26"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["33", "10"], ",", "27"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["7", "2"], ",", "28"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["37", "10"], ",", "29"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["39", "10"], ",", "30"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["41", "10"], ",", "31"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["43", "10"], ",", "32"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["9", "2"], ",", "33"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["47", "10"], ",", "34"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["7", "2"], ",", 
     FractionBox["49", "10"], ",", "35"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["11", "10"], ",", "19"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["13", "10"], ",", "20"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["3", "2"], ",", "21"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["17", "10"], ",", "22"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["19", "10"], ",", "23"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["21", "10"], ",", "24"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["23", "10"], ",", "25"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["5", "2"], ",", "26"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["27", "10"], ",", "27"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["29", "10"], ",", "28"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["31", "10"], ",", "29"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["33", "10"], ",", "30"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["7", "2"], ",", "31"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["37", "10"], ",", "32"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["39", "10"], ",", "33"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["41", "10"], ",", "34"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["43", "10"], ",", "35"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["9", "2"], ",", "36"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["47", "10"], ",", "37"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     FractionBox["9", "2"], ",", 
     FractionBox["49", "10"], ",", "38"}], "}"}]}], "}"}]], "Output"]
}, Open  ]]
}, Closed]],

Cell[CellGroupData[{

Cell["Data for Ruby Test", "Section"],

Cell[BoxData[
 RowBox[{"CopyToClipboard", "[", 
  RowBox[{"ExportString", "[", 
   RowBox[{
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"Join", "[", 
       RowBox[{
        RowBox[{"{", "kg", "}"}], ",", 
        RowBox[{"parsels", "[", "kg", "]"}]}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"kg", ",", "8", ",", "100", ",", "1"}], "}"}]}], "]"}], ",", 
    "\"\<CSV\>\""}], "]"}], "]"}]], "Input"]
}, Closed]],

Cell[CellGroupData[{

Cell["Decor", "Section"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"g1", "=", 
  RowBox[{"Column", "[", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{
       RowBox[{
        RowBox[{"Grid", "[", 
         RowBox[{
          RowBox[{"{", "#", "}"}], ",", 
          RowBox[{"Spacings", "\[Rule]", "0"}]}], "]"}], "&"}], "/@", 
       RowBox[{"Table", "[", 
        RowBox[{
         RowBox[{"parsels", "[", "n", "]"}], ",", 
         RowBox[{"{", 
          RowBox[{"n", ",", "8", ",", "40"}], "}"}]}], "]"}]}], "/.", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{"v_", ",", "iii_"}], "}"}], "\[RuleDelayed]", 
       RowBox[{"Flatten", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"Table", "[", 
           RowBox[{"5", ",", 
            RowBox[{"{", "v", "}"}]}], "]"}], ",", 
          RowBox[{"Table", "[", 
           RowBox[{"3", ",", 
            RowBox[{"{", "iii", "}"}]}], "]"}]}], "}"}], "]"}]}]}], "/.", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"5", "\[Rule]", 
        RowBox[{"Graphics", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"Lighter", "[", "Red", "]"}], ",", 
            RowBox[{"Rectangle", "[", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"0", ",", "0"}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"5", ",", "3"}], "}"}]}], "]"}]}], "}"}], ",", 
          RowBox[{"ImageSize", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{"50", ",", "30"}], "}"}]}]}], "]"}]}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"3", "\[Rule]", 
        RowBox[{"Graphics", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"Lighter", "[", "Blue", "]"}], ",", 
            RowBox[{"Rectangle", "[", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"0", ",", "0"}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"3", ",", "3"}], "}"}]}], "]"}]}], "}"}], ",", 
          RowBox[{"ImageSize", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{"30", ",", "30"}], "}"}]}]}], "]"}]}]}], "}"}]}], ",", 
    RowBox[{"Alignment", "\[Rule]", "Right"}], ",", 
    RowBox[{"Spacings", "\[Rule]", "0"}]}], "]"}]}]], "Input"],

Cell[BoxData[
 TagBox[GridBox[{
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}], 
         GraphicsBox[
          {RGBColor[
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333], 1], 
           RectangleBox[{0, 0}, {3, 3}]},
          ImageSize->{30, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]},
    {
     TagBox[GridBox[{
        {
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}], 
         GraphicsBox[
          {RGBColor[1, 
            NCache[
             Rational[1, 3], 0.3333333333333333], 
            NCache[
             Rational[1, 3], 0.3333333333333333]], 
           RectangleBox[{0, 0}, {5, 3}]},
          ImageSize->{50, 30}]}
       },
       AutoDelete->False,
       GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
       
       GridBoxSpacings->{"Columns" -> {{0}}}],
      "Grid"]}
   },
   DefaultBaseStyle->"Column",
   GridBoxAlignment->{"Columns" -> {{Right}}},
   GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
   GridBoxSpacings->{"Columns" -> {{Automatic}}, "Rows" -> {{0}}}],
  "Column"]], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"g2", "=", 
  RowBox[{"ImageReflect", "[", 
   RowBox[{"Rasterize", "[", 
    RowBox[{
     RowBox[{"Rotate", "[", 
      RowBox[{"g1", ",", 
       RowBox[{"\[Pi]", "/", "2"}]}], "]"}], ",", 
     RowBox[{"Background", "\[Rule]", "None"}]}], "]"}], "]"}]}]], "Input"],

Cell[BoxData[
 GraphicsBox[
  TagBox[RasterBox[CompressedData["
1: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
wI9Vfytqa2tra79HGwCAH6v+Vqy2L1V3Xm1fqu682gYA4MeqvxWr7UvVnVfb
l6o7r7YBAPix6m/FavtSdefV9qXqzqttAAB+rPpbsdq+VN15tX2puvNqGwDg
VTx+x6xeH9rR34rZtlvTdmvvu/NoGwDgVVR/r2lra2tra/9qGwDgVVR/r2lr
a2tra/9qGwDgVVR/r2lra2tra/9qGwDgVVR/r2lra2tra/9qGwDgVVR/r2lr
a2tra/9qGwDgVVR/r1Xbl6o7r7YvVXdebQMA8GPV34rV9qXqzqvtS9WdV9sA
APxY9bditX2puvNq+1J159U2AAA/Vv2tWG1fqu682r5U3Xm1DQDwKh6/Y1av
D+3ob8Vs261pu7X33Xm1fXhrAAA/I/t7TVtbW1tb+4XbAAA/o/qbSVtbW1tb
+5XbAAA/o/qbSVtbW1tb+5XbAAA/o/qbSVtbW1tb+5XbAAA/o/qbSVtbW1tb
+5XbAAA/o/qbqdq+VN15tX2puvNq+1J1bgDg9VR/K1bbl6o7r7YvVXdebV+q
zg0AvJ7qb8Vq+1J159X2perOq+1L1bkBgNdT/a1YbV+q7rzavlTdebV9qTo3
APDHPL7PV68P7ehvxWzbrWm7tffdebUdvTUA4PVkf69pa2tra2tr/6E2APB6
qr9btLW1tbW1tf9YGwB4PdXfLdra2tra2tp/rA0AvJ7q7xZtbW1tbW3tP9YG
AF5P9XeLtra2tra29h9rAwCvp/q7pdq+VN15tX2puvNq+5KdAwCvovq7pdq+
VN15tX2puvNq+5KdAwCvovq7pdq+VN15tX2puvNq+5KdAwCvovq7pdq+VN15
tX2puvNq+5KdAwA/4/Gdunp9aEd/t2Tbbk3brb3vzqtttzZvAwB/TPW3g7a2
tra2tvbrtQGAP6b620FbW1tbW1v79doAwB9T/e2gra2tra2t/XptAOCPqf52
0NbW1tbW1n69NgDwx1R/O2hra2tra2u/XhsA+GOqvx2q7UvVnVfbl6o7r7Yv
VXde/XsDwCur/naoti9Vd15tX6ruvNq+VN159e8NAK+s+tuh2r5U3Xm1fam6
82r7UnXn1b83ALyy6m+HavtSdefV9qXqzqvtS9WdV//eAPCrHt9rq9eHdvS3
Q7bt1rTd2vvuvNp2a6k2ALyy6ve3tra2tra2tvbPtAHglVW/v7W1tbW1tbW1
f6YNAK+s+v2tra2tra2trf0zbQB4ZdXvb21tbW1tbW3tn2kDwCurfn9ra2tr
a2tra/9MGwBeWfX7u9q+VN15tX2puvNq+1J159U2ALyy6vd3tX2puvNq+1J1
59X2perOq20AeGXV7+9q+1J159X2perOq+1L1Z1X2wDwyqrf39X2perOq+1L
1Z1X25eqO6+2AeBXPb5bVq8P7ej3d7bt1rTd2vvuvNp2a9qjNgD8qup3qLa2
tra2trb2q7QB4FdVv0O1tbW1tbW1tV+lDQC/qvodqq2tra2tra39Km0A+FXV
71BtbW1tbW1t7VdpA8Cvqn6Hamtra2tra2u/ShsAflX1O7TavlTdebV9qbrz
avtSdefVNgC8sur3d7V9qbrzavtSdefV9qXqzqttAHhl1e/vavtSdefV9qXq
zqvtS9WdV9sA8Mqq39/V9qXqzqvtS9WdV9uXqjuvtgHgVz2+W1avD+3o93e2
7da03dr77rzadmvagVsD4D1kv0O1tbW1tbW1tbV/2AbgPVS/x7S1tbW1tbW1
tX/cBuA9VL/HtLW1tbW1tbW1f9wG4D1Uv8e0tbW1tbW1tbV/3AbgPVS/x7S1
tbW1tbW1tX/cBuA9VL/Hqu1L1Z1X25eqO6+2L1V3Xm1fqs4NwOepfn9X25eq
O6+2L1V3Xm1fqu682r5UnRuAz1P9/q62L1V3Xm1fqu682r5U3Xm1fak6NwCf
p/r9XW1fqu682r5U3Xm1fam682r7UnVugHfz+IxdvT60o9/f2bZb03Zr77vz
atutabu1L50bgM+T/Q7V1tbW1tbW1tZ+6jYAn6f6XaKtra2tra2trf3cbQA+
T/W7RFtbW1tbW1tb+7nbAHye6neJtra2tra2trb2c7cB+DzV7xJtbW1tbW1t
be3nbgPwearfJdX2perOq+1L1Z1X25eqO6+2L9k5AL+q+l1SbV+q7rzavlTd
ebV9qbrzavuSnQPwq6rfJdX2perOq+1L1Z1X25eqO6+2L9k5AL+q+l1SbV+q
7rzavlTdebV9qbrzavuSnQO8h8fn3Or1oR39Lsm23Zq2W3vfnVfbbk3brb3t
zgHeTfXzXFtbW1tbW1tbW/t7bYB3U/0819bW1tbW1tbW1v5eG+DdVD/PtbW1
tbW1tbW1tb/XBng31c9zbW1tbW1tbW1t7e+1Ad5N9fNcW1tbW1tbW1tb+3tt
gHdT/Tyvti9Vd15tX6ruvNq+VN15tX2puvPq3xvgK1Q/z6vtS9WdV9uXqjuv
ti9Vd15tX6ruvPr3BvgK1c/zavtSdefV9qXqzqvtS9WdV9uXqjuv/r0BvkL1
87zavlTdebV9qbrzavtSdefV9qXqzqt/b+B9PT5rVq8P7ejnebbt1rTd2vvu
vNp2a9pu7X13ftgG+ArVz1RtbW1tbW1tbW3tZ2wDfIXqZ6q2tra2tra2trb2
M7YBvkL1M1VbW1tbW1tbW1v7GdsAX6H6maqtra2tra2tra39jG2Ar1D9TNXW
1tbW1tbW1tZ+xjbAV6h+plbbl6o7r7YvVXdebV+q7rzavlTdebUN8BWqn6nV
9qXqzqvtS9WdV9uXqjuvti9Vd15tA3yF6mdqtX2puvNq+1J159X2perOq+1L
1Z1X2wBfofqZWm1fqu682r5U3Xm1fam682r7UnXn1Tbwvh7v99XrQzv6mZpt
uzVtt/a+O6+23Zq2W3vfnUfbwPuqfq5pa2tra2tra2tra3v2h4rq55q2tra2
tra2tra2tmd/qKh+rmlra2tra2tra2tre/aHiurnmra2tra2tra2tra2Z3+o
qH6uaWtra2tra2tra2t79oeK6udatX2puvNq+1J159X2perOq+1L1Z1X2wBf
ofqZWm1fqu682r5U3Xm1fam682r7UnXn1TbAV6h+plbbl6o7r7YvVXdebV+q
7rzavlTdebUN8BWqn6nV9qXqzqvtS9WdV9uXqjuvti9Vd15tA+/r8X5fvT60
o5+p2bZb03Zr77vzatutabu19915tX14a8DXyn6uaWtra2tra2tra2s/TRv4
WtXPFm1tbW1tbW1tbW3t52kDX6v62aKtra2tra2tra2t/Txt4GtVP1u0tbW1
tbW1tbW1tZ+nDXyt6meLtra2tra2tra2tvbztIGvVf1sqbYvVXdebV+q7rza
vlTdebV9qbrzavtSdW4oqH6mVtuXqjuvti9Vd15tX6ruvNq+VN15tX2pOjcU
VD9Tq+1L1Z1X25eqO6+2L1V3Xm1fqu682r5UnRsKqp+p1fal6s6r7UvVnVfb
l6o7r7YvVXdebV+qzg0rj7tfvT60o5+p2bZb03Zr77vzatutabu19915tR29
NSjIfq5pa2tra2tra2tra2tDRPX9ra2tra2tra2tra2tDRXV97e2tra2tra2
tra2tjZUVN/f2tra2tra2tra2traUFF9f2tra2tra2tra2tra0NF9f1dbV+q
7rzavlTdebV9qbrzavtSdefV9iU7h/dVfX9X25eqO6+2L1V3Xm1fqu682r5U
3Xm1fcnO4X1V39/V9qXqzqvtS9WdV9uXqjuvti9Vd15tX7JzeF/V93e1fam6
82r7UnXn1fal6s6r7UvVnVfbl+wcvtbj9lavD+3o+zvbdmvabu19d15tuzVt
t/a+O6+23dq8DSvV95i2tra2tra2tra2tvZ1G1aq7zFtbW1tbW1tbW1tbe3r
NqxU32Pa2tra2tra2tra2trXbVipvse0tbW1tbW1tbW1tbWv27BSfY9pa2tr
a2tra2tra2tft2Gl+h6rti9Vd15tX6ruvNq+VN15tX2puvNq+1J159W/Ny3V
91i1fam682r7UnXn1fal6s6r7UvVnVfbl6o7r/69aam+x6rtS9WdV9uXqjuv
ti9Vd15tX6ruvNq+VN159e/N1l/+8tuff3/9dfj689/3q++xYtutabu19915
te3WtN3a++682nZrvTYdj/fb9tR+++vf96vvsWLbrWmv2m5Ne9V2a9qrtlvT
XrXdWq9Nh/e39qrt1rRXbbemvWq7Ne1V261pr9purdemw/tbe9V2a9qrtlvT
XrXdmvaq7da0V2231mvT4f2tvWq7Ne1V261pr9puTXvVdmvaq7Zb67Xp8P7W
XrXdmvaq7da0V223pr1quzXtVdut9dp0eH9rr9puTXvVdmvaq7Zb01613Zr2
qu3Wem06vL977Sturde+4tZ67Sturde+4tZ67Sturdemw/u7177i1nrtK26t
177i1nrtK26t177i1nptOry/e+0rbq3XvuLWeu0rbq3XvuLWeu0rbq3XpsP7
u9e+4tZ67Sturde+4tZ67Sturde+4tZ6bfYef4PV6++73t/Btltr/b3dmlsr
tN1a6+/t1txaoe3WWn/vwzZ7V39v72/tVdutaa/abk171XZr2qu2W9Netd1a
r83e1d/b+1t71XZr2qu2W9Netd2a9qrt1rRXbbfWa7N39ff2/tZetd2a9qrt
1rRXbbemvWq7Ne1V26312uxd/b29v7VXbbemvWq7Ne1V261pr9puTXvVdmu9
NntXf2/vb+1V261pr9puTXvVdmvaq7Zb01613Vqvzd7V39v7u/cec2tubcWt
ubUVt+bWVtyaW1txa26N9+X97f294tbc2opbc2srbs2trbg1t7bi1twa78v7
2/t7xa25tRW35tZW3JpbW3Frbm3Frbk13pf3t/f3iltzaytuza2tuDW3tuLW
3NqKW3NrfK3H32D1+tD2/k69v92aW3Nrbs2tuTW35tbcmltza27t+taqirfm
/a29ars17VXbrWmv2m5Ne9V2a9qrtlvrtauKf2/vb+1V261pr9puTXvVdmva
q7Zb01613VqvXVX8e3t/a6/abk171XZr2qu2W9Netd2a9qrt1nrtquLf2/tb
e9V2a9qrtlvTXrXdmvaq7da0V2231mtXFf/e3t/aq7Zb01613Zr2qu3WtFdt
t6a9aru1Xruq+Pcuv78vuTW3tuLW3NqKW3NrK27Nra24Nbe2Up370uXOL9uP
9/jq9Uw7v+TW3NqKW3NrK27Nra24Nbe24tbc2kp17kvV9/clc7u1FXO7tRVz
u7UVc7u1FXO7tRVzd+b+2z//+evw9ee/7xff39WdV+e2c3O7tffdeXVuOze3
W3vfnVfntnNzL2/tymMH27Gf598vubzz4s6rc9u5uVdz27m5V3PbublXc9u5
uVdz27m5V3NfKu/8ql3deXVuOzf3am47N/dqbjs392puOzf3am47N/dq7kvl
nV+1qzuvzm3n5l7NbefmXs1t5+ZezW3n5l7NbefmXs19qbzzq3Z159W57dzc
q7nt3Nyrue3c3Ku57dzcq7nt3NyruS+Vd37Vru68Oredm3s1t52bezW3nZt7
Nbedm3s1t52bezX3pfLOr9rVnVfntnNzr+a2c3Ov5rZzc6/mtnNzr+a2c3Ov
5r5U3vlV+3rnV67ndmtuza25tc92Pbdbc2tuza19tuu53ZpbK9zalfLOr9rX
O79yPbdbc2tuza19tuu53Zpbc2tu7bNdz+3W3Frh1q6Ud37Vvt75leu53Zpb
c2tu7bNdz+3W3Jpbc2uf7Xput+bWCrd2pbzzq/b1zq9cz+3W3Jpbc2uf7Xpu
t+bW3Jpb+2zXc7s1t5a4td//++pl57ft8527Nbfm1tyaW3Nrbs2tuTW35tbc
mltza3Zu5+b+tLnt3Nyrue3c3Ku57dzcq7nt3Nyrue3c3Ku57dzOCzuvzm3n
5l7NbefmXs1t5+ZezW3n5l7NbefmXs1t53Ze2Hl1bjs392puOzf3am47N/dq
bjs392puOzf3am47t/PCzqtz27m5V3PbublXc9u5uVdz27m5V3PbublXc9u5
nRd2Xp3bzs29mtvOzb2a287NvZrbzs29mtvOzb2a287tvLDz6tx2bu7V3HZu
7tXcdm7u1dx2bu7V3HZu7tXcdm7nhZ1X57Zzc6/mtnNzr+a2c3Ov5rZzc6/m
tnNzr+a2czsv7Lw6t52bezW3nZt7Nbedm3s1t52bezW3nZt7Nbed23lh59W5
7dzcq7nt3Nyrue3c3Ku57dzcq7nt3Nyrue3czgs7r85t5+ZezW3n5l7Nbefm
Xs1t5+ZezW3n5l7Nbed2Xth5dW47N/dqbjs392puOzf3am47N/dqbjs392pu
O7fzws6rc9u5uVdz27m5V3PbublXc9u5uVdz27m5V3PbuZ0Xdl6d287NvZrb
zs29mtvOzb2a287NvZrbzs29mtvO7byw8+rcdm7u1dx2bu7V3HZu7tXcdm7u
1dx2bu7V3HZu54WdV+e2c3Ov5rZzc6/mtnNzr+a2c3Ov5rZzc6/mtvObnV+p
7rw696XqzqtzX6ruvDr3perOq3Nfqu68Ovel6s6rc1+3H3tfvf79rV/Ofam6
8+rcl6o7r859qbrz6tyXqjuvzn2puvPq3JeqO6/OXb3z6tyXqjuvzn2puvPq
3JeqO6/Ofam68+rcl6o7r859qbrzy7mv2n/75yB/Hb7yc9u5ud3a++68Ored
m9utve/Oq3Pbubnd2vvu/HLu651v08/x71lczm3n5l7NbefmXs1t5+ZezW3n
5l7NbefmXs1t56257bw1t52bezW3nZt7Nbedm3s1t52bezW3nZt7Nbedt+a2
89bcdm7u1dx2bu7V3HZu7tXcdm7u1dx2bu7V3HbemtvOW3PbublXc9u5uVdz
27m5V3PbublXc9u5uVdz23lrbjtvzW3n5l7NbefmXs1t5+ZezW3n5l7Nbefm
Xs1t56257bw1t52bezW3nZt7Nbedm3s1t52bezW3nZt7Nbedt+Yu7/yK97db
W3Frbm3Frbm1Fbfm1lbcmltbcWtubcnOt7y/3dqKW3NrK27Nra24Nbe24tbc
2opbc2tLdr7l/e3WVtyaW1txa25txa25tRW35tZW3JpbW7LzLe9vt7bi1tza
iltzaytuza2tuDW3tuLW3NpSdeeP/y2r1993vb/dmltza27Nrbk1t+bW3Jpb
c2vXc5/v3K1Nby298+Dcdm7u1dx2bu7V3HZu7tXcdm7u1dx2bu7V3HbemtvO
W3PbublXc9u5uVdz27m5V3PbublXc9u5uVdz23lrbjtvzW3n5l7NbefmXs1t
5+ZezW3n5l7NbefmXs1t56257bw1t52bezW3nZt7Nbedm3s1t52bezW3nZt7
Nbedt+a289bcdm7u1dx2bu7V3HZu7tXcdm7u1dx2bu7V3HbemtvOW3PbublX
c9u5uVdz27m5V3PbublXc9u5uVdz23lrbjtvzW3n5l7NbefmXs1t5+ZezW3n
5l7NbefmXs1t56257bw1t52bezW3nZt7Nbedm3s1t52bezW3nZt7Nbedt+a2
89bcdm7u1dx2bu7V3HZu7tXcdm7u1dx2bu7V3HbemtvOW3PbublXc9u5uVdz
27m5V3PbublXc9u5uVdz23lrbjtvzW3n5l7NbefmXs1t5+ZezW3n5l7Nbefm
Xs1t56257bw1t52bezW3nZt7Nbedm3s1t52bezW3nZt7Nbedt+a289bcdm7u
1dx2bu7V3HZu7tXcdm7u1dx2bu7V3HbemtvOW3PbublXc9u5uVdz27m5V3Pb
ublXc9u5uVdz23lrbjtvzW3n5l7NbefmXs1t5+ZezW3n5l7NbefmXs1t5625
L1V3Xn5/X7me2625Nbfm1j7b9dxuza25Nbf22a7ndmtu7d1v7dpj76vXv29f
7vxy7sv2Jbfm1lbcmltbcWtubcWtubUVt+bWVqq3VmXnrLg1VtwaK26NFbfG
iltj5erW/vbPIv46fD1F28613dr77rzadmvabu19d15tuzVtt/a+O6+2r29t
m36ef7/EzrUXbbemvWq7Ne1V261pr9puTXvVdmvaq7Zbs/PCzqttt6a9ars1
7VXbrWmv2m5Ne9V2a9qrtluz88LOq223pr1quzXtVdutaa/abk171XZr2qu2
W7Pzws6rbbemvWq7Ne1V261pr9puTXvVdmvaq7Zbs/PCzqttt6a9ars17VXb
rWmv2m5Ne9V2a9qrtluz88LOq223pr1quzXtVdutaa/abk171XZr2qu2W7Pz
ws6rbbemvWq7Ne1V261pr9puTXvVdmvaq7Zbs/PCzqttt6a9ars17VXbrWmv
2m5Ne9V2a9qrtluz88LOq223pr1quzXtVdutaa/abk171XZr2qu2W7Pzws6r
bbemvWq7Ne1V261pr9puTXvVdmvaq7Zbs/PCzqttt6a9ars17VXbrWmv2m5N
e9V2a9qrtluz88LOq223pr1quzXtVdutaa/abk171XZr2qu2W7Pzws6rbbem
vWq7Ne1V261pr9puTXvVdmvaq7Zbs/PCzqttt6a9ars17VXbrWmv2m5Ne9V2
a9qrtluz88LOq223pr1quzXtVdutaa/abk171XZr2qu2W7Pzws6rbbemvWq7
Ne1V261pr9puTXvVdmvaq7Zbs/PCzqttt6a9ars17VXbrWmv2m5Ne9V2a9qr
tluz88LOq223pr1quzXtVdutaa/abk171XZr2qu2W7Pzws6rbbemvWq7Ne1V
261pr9puTXvVdmvaq7Zbs/PCzqttt6a9ars17VXbrWmv2m5Ne9V2a9qrtluz
88LOq223pr1quzXtVdutaa/abk171XZr2qu2W7Pzws6rbbemvWq7Ne1V261p
r9puTXvVdmvaq7Zbs/PCzqttt6a9ars17VXbrWmv2m5Ne9V2a9qrtluz88LO
q223pr1quzXtVdutaa/abk171XZr2qu2W7Pzws6rbbemvWq7Ne1V261pr9pu
TXvVdmvaq7Zbs/PCzqttt6a9ars17VXbrWmv2m5Ne9V2a9qrtlu72fmV6s6r
7UvVnVfbl6o7r7YvVXdebV+q7rzavlTdebV97TH76vVM7UvVnVfbl6o7r7Yv
VXdebV+q7rzavlTdebV9qbrzahsAAAAAAAAA4Gf9P+dW2rY=
    "], {{0, 402}, {1023, 
    0}}, {0, 255},
    ColorFunction->RGBColor],
   BoxForm`ImageTag["Byte", ColorSpace -> "RGB", Interleaving -> True],
   Selectable->False],
  BaseStyle->"ImageGraphics",
  ImageSize->{1023, 402},
  ImageSizeRaw->{1023, 402},
  PlotRange->{{0, 1023}, {0, 402}}]], "Output"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Export", "[", 
  RowBox[{
  "\"\<~/Sites/parsels/app/assets/images/bg.png\>\"", ",", "g2", ",", 
   RowBox[{"Background", "\[Rule]", "None"}]}], "]"}]], "Input"],

Cell[BoxData["\<\"~/Sites/parsels/app/assets/images/bg.png\"\>"], "Output"]
}, Open  ]]
}, Closed]]
}, Open  ]]
},
Visible->True,
ScrollingOptions->{"VerticalScrollRange"->Fit},
ShowCellBracket->Automatic,
CellContext->Notebook,
TrackCellChangeTimes->False,
FrontEndVersion->"10.0 for Mac OS X x86 (32-bit, 64-bit Kernel) (June 20, \
2013)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1486, 35, 24, 0, 92, "Title"],
Cell[1513, 37, 90, 2, 30, "Text"],
Cell[CellGroupData[{
Cell[1628, 43, 32, 0, 80, "Section"],
Cell[1663, 45, 571, 15, 220, "Text"]
}, Open  ]],
Cell[CellGroupData[{
Cell[2271, 65, 35, 0, 80, "Section"],
Cell[2309, 67, 122, 3, 27, "Text"],
Cell[2434, 72, 48, 0, 30, "Text"],
Cell[CellGroupData[{
Cell[2507, 76, 52, 1, 28, "Input"],
Cell[2562, 79, 29, 0, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[2628, 84, 52, 1, 28, "Input"],
Cell[2683, 87, 32, 0, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[2752, 92, 83, 2, 28, "Input"],
Cell[2838, 96, 29, 0, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[2904, 101, 102, 3, 28, "Input"],
Cell[3009, 106, 29, 0, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3075, 111, 129, 4, 28, "Input"],
Cell[3207, 117, 28, 0, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3272, 122, 195, 6, 28, "Input"],
Cell[3470, 130, 32, 0, 28, "Output"]
}, Open  ]],
Cell[3517, 133, 49, 0, 30, "Text"],
Cell[CellGroupData[{
Cell[3591, 137, 107, 3, 28, "Input"],
Cell[3701, 142, 29, 0, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3767, 147, 153, 5, 28, "Input"],
Cell[3923, 154, 29, 0, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3989, 159, 182, 6, 28, "Input"],
Cell[4174, 167, 28, 0, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[4239, 172, 255, 9, 28, "Input"],
Cell[4497, 183, 31, 0, 28, "Output"]
}, Open  ]],
Cell[4543, 186, 65, 0, 30, "Text"],
Cell[CellGroupData[{
Cell[4633, 190, 208, 7, 49, "Input"],
Cell[4844, 199, 28, 0, 28, "Output"]
}, Open  ]],
Cell[4887, 202, 29, 0, 30, "Text"],
Cell[CellGroupData[{
Cell[4941, 206, 96, 3, 28, "Input"],
Cell[5040, 211, 29, 0, 28, "Output"]
}, Open  ]]
}, Closed]],
Cell[CellGroupData[{
Cell[5118, 217, 54, 0, 50, "Section"],
Cell[CellGroupData[{
Cell[5197, 221, 55, 0, 36, "Subsection"],
Cell[5255, 223, 1458, 44, 40, "Input"],
Cell[CellGroupData[{
Cell[6738, 271, 61, 1, 28, "Input"],
Cell[6802, 274, 74, 2, 28, "Output"]
}, Open  ]]
}, Closed]],
Cell[CellGroupData[{
Cell[6925, 282, 58, 0, 36, "Subsection"],
Cell[6986, 284, 251, 8, 22, "Input"],
Cell[7240, 294, 243, 7, 28, "Input"],
Cell[7486, 303, 324, 9, 28, "Input"],
Cell[CellGroupData[{
Cell[7835, 316, 100, 2, 28, "Input"],
Cell[7938, 320, 112, 2, 28, "Output"]
}, Open  ]]
}, Closed]],
Cell[CellGroupData[{
Cell[8099, 328, 38, 0, 36, "Subsection"],
Cell[CellGroupData[{
Cell[8162, 332, 313, 10, 22, "Input"],
Cell[8478, 344, 10085, 293, 1593, "Output"]
}, Open  ]]
}, Closed]],
Cell[CellGroupData[{
Cell[18612, 643, 35, 0, 36, "Subsection"],
Cell[18650, 645, 40, 0, 27, "Text"],
Cell[CellGroupData[{
Cell[18715, 649, 511, 15, 28, "Input"],
Cell[19229, 666, 31, 0, 28, "Output"]
}, Open  ]]
}, Closed]],
Cell[CellGroupData[{
Cell[19309, 672, 27, 0, 36, "Subsection"],
Cell[CellGroupData[{
Cell[19361, 676, 2249, 63, 91, "Input"],
Cell[21613, 741, 5336, 118, 434, "Output"]
}, Open  ]]
}, Closed]]
}, Closed]],
Cell[CellGroupData[{
Cell[27010, 866, 43, 0, 50, "Section"],
Cell[27056, 868, 16475, 275, 112, "Input"],
Cell[CellGroupData[{
Cell[43556, 1147, 31, 0, 44, "Subsection"],
Cell[43590, 1149, 66, 0, 27, "Text"],
Cell[CellGroupData[{
Cell[43681, 1153, 250, 7, 28, "Input"],
Cell[43934, 1162, 190, 4, 28, "Output"]
}, Open  ]],
Cell[44139, 1169, 120, 4, 30, "Text"],
Cell[CellGroupData[{
Cell[44284, 1177, 73, 1, 28, "Input"],
Cell[44360, 1180, 189, 6, 44, "Output"]
}, Open  ]],
Cell[44564, 1189, 118, 3, 30, "Text"],
Cell[CellGroupData[{
Cell[44707, 1196, 889, 27, 63, "Input"],
Cell[45599, 1225, 1591, 37, 160, "Output"]
}, Open  ]]
}, Closed]],
Cell[CellGroupData[{
Cell[47239, 1268, 31, 0, 36, "Subsection"],
Cell[47273, 1270, 66, 0, 27, "Text"],
Cell[CellGroupData[{
Cell[47364, 1274, 250, 7, 28, "Input"],
Cell[47617, 1283, 190, 4, 28, "Output"]
}, Open  ]],
Cell[47822, 1290, 226, 6, 30, "Text"],
Cell[CellGroupData[{
Cell[48073, 1300, 73, 1, 28, "Input"],
Cell[48149, 1303, 901, 24, 37, "Output"]
}, Open  ]],
Cell[49065, 1330, 176, 6, 31, "Text"],
Cell[CellGroupData[{
Cell[49266, 1340, 555, 16, 28, "Input"],
Cell[49824, 1358, 1120, 28, 114, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[50981, 1391, 302, 9, 28, "Input"],
Cell[51286, 1402, 1919, 70, 48, "Output"]
}, Open  ]],
Cell[53220, 1475, 147, 4, 30, "Text"],
Cell[CellGroupData[{
Cell[53392, 1483, 107, 3, 28, "Input"],
Cell[53502, 1488, 3864, 132, 86, "Output"]
}, Open  ]],
Cell[57381, 1623, 96, 2, 30, "Text"],
Cell[CellGroupData[{
Cell[57502, 1629, 328, 10, 28, "Input"],
Cell[57833, 1641, 1137, 36, 28, "Output"]
}, Open  ]],
Cell[58985, 1680, 53, 0, 30, "Text"],
Cell[CellGroupData[{
Cell[59063, 1684, 448, 14, 28, "Input"],
Cell[59514, 1700, 1137, 36, 28, "Output"]
}, Open  ]],
Cell[60666, 1739, 46, 0, 30, "Text"],
Cell[CellGroupData[{
Cell[60737, 1743, 480, 15, 49, "Input"],
Cell[61220, 1760, 1919, 70, 48, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[63176, 1835, 553, 17, 65, "Input"],
Cell[63732, 1854, 507, 8, 28, "Output"]
}, Open  ]],
Cell[64254, 1865, 65, 0, 30, "Text"],
Cell[CellGroupData[{
Cell[64344, 1869, 250, 7, 28, "Input"],
Cell[64597, 1878, 507, 8, 28, "Output"]
}, Open  ]]
}, Closed]]
}, Closed]],
Cell[CellGroupData[{
Cell[65165, 1893, 31, 0, 50, "Section"],
Cell[65199, 1895, 567, 18, 22, "Input"],
Cell[CellGroupData[{
Cell[65791, 1917, 166, 5, 28, "Input"],
Cell[65960, 1924, 9621, 322, 238, "Output"]
}, Open  ]]
}, Closed]],
Cell[CellGroupData[{
Cell[75630, 2252, 37, 0, 50, "Section"],
Cell[75670, 2254, 418, 12, 22, "Input"]
}, Closed]],
Cell[CellGroupData[{
Cell[76125, 2271, 24, 0, 50, "Section"],
Cell[CellGroupData[{
Cell[76174, 2275, 2244, 64, 57, "Input"],
Cell[78421, 2341, 56216, 1776, 1041, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[134674, 4122, 291, 8, 28, "Input"],
Cell[134968, 4132, 12130, 204, 417, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[147135, 4341, 185, 4, 28, "Input"],
Cell[147323, 4347, 75, 0, 28, "Output"]
}, Open  ]]
}, Closed]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature nuDBP2MCsRGMFCg72tNjsvrL *)
