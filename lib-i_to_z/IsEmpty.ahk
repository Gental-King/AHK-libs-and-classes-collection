;
; Function: IsEmpty
; Description:
;		Determine whether a variable is considered to be empty.
; Syntax: IsEmpty(var)
; Parameters:
;		var - Variable to be checked.
; Return Value:
; 		Returns FALSE if var has a non-empty and non-zero value.
;			The following things are considered to be empty:
;				"" (an empty string)
;				0 (0 as an integer)
;				"0" (0 as a string)
;				[] (an empty array)
;				{} (an empty associative array)
; Remarks:
;		The function does not work with pseudo-arrays.
; Example:
;		x := [0, 1, "0", "1", false, true, [], [1], {}, {k:"V"}]
;			for i, testVal in x
;			{
;				msgbox, 4, "Empty test", % testVal " is " (IsEmpty(testVal) ? "empty." : "not empty.") "`nContinue?"
;				IfMsgBox, No
;					break
;			}
;

IsEmpty(var)
{
	if(!IsObject(var))
	{
		;~ OutputDebug, var is not an object: %var%
		if(var = "" || var = 0 || var = "0" || var = false)
			return true
		else
			return false
	}
	else
	{
		;~ OutputDebug, % "var is an object, count = " Count(var) 
		; If any property exists, return false
		for k, v in var
		{
			return false
		}
		return true
	}
}