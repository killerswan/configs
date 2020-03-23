If[$Failed === CurrentValue[$FrontEnd, StyleSheetPath],
	Null,

	(* otherwise, proceed! *)
	Get@FileNameJoin@{HomeDirectory[], "code/notes/kernel-init/tools.m"};

	(*
		if this is copied to $UserBaseDirectory/Kernel/init.m,
		the following stylesheet paths will only be used in loading the front end
		on a second document open: after $UserBaseDirectory has been initialized

		to impact the opened mathematica we need the stylesheet paths in $FrontEnd,
		not just $FrontEndSession

		although to impact secondary things like docs, $FrontEndSession is enough
	*)

	sheets = {
		(* list order seems unimportant to inheritance-order, here... *)
		(* Summerfruit.nb can be in this directory *)
		FrontEnd`FileName[{$HomeDirectory, "code", "notes", "kernel-init", "StyleSheets"}],
	};
	CurrentValue[$FrontEnd, StyleSheetPath] = Join[
		sheets,
		Complement[CurrentValue[$FrontEnd, StyleSheetPath] (* engine doesn't like that *), sheets]
	];

	(* set stylesheet on each new notebook *)
	(* SetOptions[$FrontEnd, DefaultStyleDefinitions -> "CommandCenter.nb"] *)

	(*
		(* show stylesheet paths *)
		CurrentValue@StyleSheetPath // TableForm
		AbsoluteCurrentValue@StyleSheetPath // TableForm

		(* set stylesheet on *this* notebook *)
		SetOptions[EvaluationNotebook[], StyleDefinitions -> "Summerfruit.nb"]
	*)

	trustedPath = CurrentValue[$FrontEnd, {"NotebookSecurityOptions", "TrustedPath"}];
	sllDir = FrontEnd`FileName[{$HomeDirectory,"SLL"}];
	If[Not@MemberQ[trustedPath, sllDir],
		SetOptions[$FrontEnd, "NotebookSecurityOptions"->{
				"TrustByDefault"->Automatic,
				"TrustedPath"->Append[trustedPath, sllDir],
				"UntrustedPath"->{}
		}]
	];

	SetOptions[$FrontEndSession, ShowPredictiveInterface -> False];

	(* SetOptions[$FrontEnd, ShowCursorTracker -> False]; *)

	(* kernels *)
	labeledKernel = {"AppendNameToCellLabel" -> True, "AutoStartOnLaunch" -> False};
	CurrentValue[$FrontEndSession, EvaluatorNames] = Normal@Association@Join[
		CurrentValue[$FrontEndSession, EvaluatorNames],
		{
		  "Kenzie" -> labeledKernel,
		  "Tamsin" -> labeledKernel,
		  "Hale" -> labeledKernel,
		  "Bo" -> labeledKernel,
		  "Dyson" -> labeledKernel
		}
	];

	(*
		this is still not entirely sufficient (here or in FrontEnd/init.m):
		the WRI bug with a zero-margin default printer
		occurs BEFORE either would be evaluated on first run
	*)
	SetOptions[$FrontEnd,
		PrintingOptions -> {
			"FirstPageFooter" -> False,
			"FirstPageHeader" -> False,
			"PrintingMargins" -> {{0, 0}, {0, 0}},
			"RestPagesFooter" -> False,
			"RestPagesHeader" -> False
		}
	];

	SetOptions[$FrontEnd,
		PrivateNotebookOptions->{
			"FinalWindowPrompt"->False
		}
	];
]
