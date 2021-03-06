


stringCaseSense, on		; on 대소문자 구분 / off 구분안함
						

object.base.length				                    		:= "string_length"					                 		;	The length of the string
object.base.replace				                    		:= "string_replace"					                		;	Replace string (replace string, replace string)
object.base.isExist				                    		:= "string_isExist"				                    			;	The existence of the string - bool
object.base.indexOf				                    		:= "string_indexOf"				                			;	The first position (string, offset = 0) of the string (first occurrence)
object.base.lastIndexOf		                    		:= "string_lastIndexOf"		             				;	If the string is the first (last) position (string, offset = 0)
object.base.trim			     	                    		:= "string_trim"					                    		;	Remove leading and trailing spaces in string
object.base.trimHead			                    		:= "string_trimHead"			                   			;	Remove leading blanks in string
object.base.trimTail			                        		:= "string_trimTail"				                    		;	Remove trailing blanks in string
object.base.getUpsideDown		            		:= "string_getUpsideDown"				            	;	String upside down
object.base.getContentBetween	            		:= "string_getContentBetween"		           		;	Returns the string between two strings (wrapped string, wrapped string)
object.base.lineCommentToBlockComment	:= "string_lineCommentToBlockComment"	;	Single-line comment [-] to block comment [/ ** /]
object.base.isWhiteSpace		                 		:= "string_isWhiteSpace"		                 			;	Check whether the syllable is a space [space, tab, enter] - bool (false if it is not a syllable and spaces are ignored)
object.base.getSeparateWord	                 		:= "string_getSeparateWord"		         			;	Split by whitespace to return a separate word for that index. The first word index is 0.
object.base.getLastWord			                 		:= "string_getLastWord"				            		;	공백을 기준으로 split 하여 마지막 어절을 반환한다.
object.base.removeLeft			                 		:= "string_removeLeft"				            		;	왼쪽 음절 제거
object.base.removeRight			                 		:= "string_removeRight"				            		;	오른쪽 음절 제거
object.base.getLastSplitWord	                 		:= "string_getLastSplitWord"		            		;	split 하여 마지막 어절을 반환한다.
object.base.substring				                    	:= "string_substring"		                				;	substring. 최초인덱스는 0 (시작위치, 길이)
object.base.removeAHKLineComment     		:= "string_removeAHKLineComment"	    		;	오토핫키 한줄코멘트 제거													
object.base.removeInnerQuotation	            	:= "string_removeInnerQuotation"	        		;	따옴표 안의 내용 제거 (동일한 행 안에서만 적용)
object.base.getLastLineContent	             		:= "string_getLastLineContent"		        		;	마지막 줄의 내용
object.base.toLowerCase			                 		:= "string_toLowerCase"				            		;	소문자로 변환
object.base.toUpperCase			                 		:= "string_toUpperCase"				            		;	대문자로 변환
object.base.isUpperCase			                 		:= "string_isUpperCase"				            		;	대문자인지 확인. 음절만 체크.
object.base.isLowerCase			                 		:= "string_isLowerCase"				            		;	소문자인지 확인. 음절만 체크.
object.base.isAlphabet				                    	:= "string_isAlphabet"					                	;	알파벳인지 확인. 음절만 체크.
object.base.isNumber				                     	:= "string_isNumber"				                 		;	숫자인지 확인. 음절만 체크. 
object.base.removeTag			                 		:= "string_removeTag"				             		;	테그 제거 (스크립트도 제거)
object.base.underbarToCamel		            		:= "string_underbarToCamel"			         		;	언더바형식 문자열을 카멜 형식으로 변환
object.base.camelToUnderbar		            		:= "string_camelToUnderbar"			         		;	카멜형식 문자열을 언더바 형식으로 변환
object.base.split				                        		:= "string_split"					                     		;	Array split(deliminator)
object.base.getPostPosition := "string_getPostPosition"
object.base.getPreLetter := "string_getPreLetter"
object.base.isVarExist := "string_isVarExist"
object.base.getPostLetter := "string_getPostLetter"
object.base.isVarLetter := "string_isVarLetter"
object.base.getPosition := "string_getPosition"

string_length(this){
	return strLen(this)
}
string_replace(this, old, new){
	StringReplace, result, this, %old%, %new%, all
	return result
}
string_isExist(this, needle){
	IfInString, this, %needle%
	{
		return true
	}		
	else
	{
		return false
	}
}
string_indexOf(this, needle, offset = 0){
	position	:= -1
	StringGetPos, position, this, %needle%, L1, offset
	return position
}
string_lastIndexOf(this, needle, offset = 0){
	position	:= -1
	StringGetPos, position, this, %needle%, R1, offset
	return position
}
string_trimHead(this){
	content				:= this
	new_content			:= ""
	is_trimming			:= false

	loop, parse, content
	{
		if( a_index == 1 && (a_loopfield == " " || a_loopfield == a_tab || a_loopfield == "`n" || a_loopfield == "`r" || a_loopfield == "`r`n" || a_loopfield == "`n`r") )
		{
			is_trimming := true
		}
		else if(is_trimming == true && (a_loopfield == " " || a_loopfield == a_tab || a_loopfield == "`n" || a_loopfield == "`r" || a_loopfield == "`r`n" || a_loopfield == "`n`r"))
		{
			is_trimming := true
		}
		else
		{
			is_trimming := false
		}

		if(!is_trimming)
		{
			new_content	.= a_loopfield
		}
	}	

	return new_content
}
string_getUpsideDown(this){
	content := this
	
	StringSplit, target_array, content

	upsideDown := ""
	
	loop, %target_array0%
	{
		new_index	:= target_array0 - a_index + 1
		upsideDown	.= target_array%new_index%

	}
	return upsideDown
}
string_trim(this){
	this := this.trimHead()
	this := this.getUpsideDown()
	this := this.trimHead()
	this := this.getUpsideDown()

	return this
}
string_trimTail(this){
	this := this.getUpsideDown()
	this := this.trimHead()
	this := this.getUpsideDown()

	return this
}
string_getContentBetween(this, between_start, between_end){
	content				:= this
	between_content		:= ""
	is_in_between		:= false
	
	if((between_start != "" && this.indexOf(between_start) == -1) || (between_end != "" && this.indexOf(between_end) == -1)){
		return ""
	}
	
	start_position		:= this.indexOf(between_start) + StrLen(between_start) + 1
	end_position		:= this.indexOf(between_end, start_position - 1)

	if(between_start == "")		;찾을 시작 문자열이 공백이면 처음부터
	{
		start_position	:= "1"
	}
	if(between_end == "")		;찾을 끝 문자열이 공백이면 마지막까지
	{
		end_position	:= StrLen(content)
	}

	if(start_position == -1 || end_position == -1)
	{
		return ""
	}

	length				:= end_position - start_position + 1

	return SubStr(content, start_position, length)
}
string_lineCommentToBlockComment(this){
	if(this.isExist("--") && !this.isExist("!--"))
	{
		return this.replace("--", "/*") . " */"
	}
	else
	{
		return this
	}
}
string_getSeparateWord(this, index){                                                       	; Split by whitespace to return a separate word for that index. The first word index is 0.
	this					:= this.trim()
	in_white_space			:= false
	current_separate_word	:= ""
	separate_word_count		:= "0"

	loop, parse, this,
	{
		test1 := a_index

		if(a_loopfield.isWhiteSpace() && in_white_space == false)		;공백시작
		{
			in_white_space := true
			separate_word_count ++

			if(index == separate_word_count - 1)
			{
				return current_separate_word
			}
			else
			{
				current_separate_word := ""
			}

		}
		else if(a_loopfield.isWhiteSpace() == false && a_index != this.length())				;내용부분(마지막 제외)
		{
			in_white_space := false
			current_separate_word	.= a_loopfield
		}
		else if(a_index == this.length())		;마지막
		{
			separate_word_count++
			current_separate_word	.= a_loopfield
			if(index == separate_word_count - 1)
			{
				return current_separate_word
			}
		}
	}

	return ""
}
string_getLastWord(this){                                                                        	; It returns the last word by splitting it with a space and "(".
	new_content 	:= this.getUpsideDown().trim()	
	last_word		:= ""
	
	loop, parse, new_content,
	{
		if(!a_loopfield.isWhiteSpace() && a_loopfield != "("){
			last_word .= a_loopfield
		}else{
			return last_word.getUpsideDown()
		}
	}
	
	return last_word.getUpsideDown()
}
string_getLastSplitWord(this, deliminator){                                             	; Split to the syllable and return the last word.
	new_content 	:= this.getUpsideDown().trim()	
	last_word		:= ""
	
	loop, parse, new_content,
	{
		if(a_loopfield != deliminator){
			last_word .= a_loopfield
		}else{
			return last_word.getUpsideDown()
		}
	}
	
	return last_word.getUpsideDown()
}
string_isWhiteSpace(this){
	if(this == a_space || this == a_tab || this == "`n" || this == "`r" || this == "`n`r")
	{
		return true
	}
	return false
}
string_substring(this, index, length){
	content		:= this
	
	return substr(content, index + 1, length)
}
string_removeAHKLineComment(this){
	content		:= this
	new_content	:= ""
	
	loop, parse, content, `n
	{
		current_line	:= a_loopfield
		sleep, 1
				
		// 주석 제거
		if(current_line.isExist(";"))
		{
			current_line := current_line.substring(0, current_line.indexOf(";"))
		}
		
		if(new_content != "")
			new_content .= "`n"
			
		new_content .= current_line
	}
	
	return new_content
}
string_removeInnerQuotation(this){
	content 	:= this
	new_content	:= ""
	q			:= """"
	is_inner_q	:= false
	
	loop, parse, content,
	{
		if(a_loopfield == q)
		{
			if(is_inner_q == false)
			{
				is_inner_q := true
			}
			else
			{
				is_inner_q := false
			}
			
			new_content .= a_loopfield
		}
		else if(a_loopfield == "`n")
		{
			is_inner_q := false
			
			new_content .= a_loopfield
		}
		else
		{
			if(is_inner_q == false)
			{
				new_content .= a_loopfield
			}
		}
	}
	
	return new_content
}
string_toLowerCase(this){
	stringLower, lower, this
	return lower
}
string_toUpperCase(this){
	stringUpper, upper, this
	return upper
}
string_split(this, deliminator){
	content			:= this
	result_array	:= new Array()
	
	StringSplit, split_array, content, %deliminator%, 
		
	loop % split_array0
	{
		current := split_array%a_index%
		result_array.add(current)
	}
		
	return result_array
}
string_getLastLineContent(this){
	loop, parse, this, `n
	{
		current_line := a_loopfield
	}
	
	return current_line
}
string_isUpperCase(this){
	if(this.length() != "1"){
		return false
	}
	
	if(asc(this) >= 65 && asc(this) <= 90){
		return true
	}else{
		return false
	}
}
string_isLowerCase(this){
	if(this.length() != "1"){
		return false
	}
		
	if(asc(this) >= 97 && asc(this) <= 122){
		return true
	}else{
		return false
	}
}
string_isAlphabet(this){
	if(this.length() != "1"){
		return false
	}
		
	if(this.isUpperCase(this) || this.isLowerCase(this)){
		return true
	}else{
		return false
	}
}
string_isNumber(this){
	if(this.length() != "1"){
		return false
	}
	
	if(asc(this) >= 48 && asc(this) <= 57){
		return true
	}else{
		return false
	}
}
string_removeTag(this){
	content			:= this
	tag_array 		:= new Array()
	
	tag_array.add("p")
	tag_array.add("br")
	tag_array.add("div")
	tag_array.add("span")
	tag_array.add("img")
	tag_array.add("a")
	tag_array.add("strong")
	tag_array.add("b")
	tag_array.add("font")
	tag_array.add("table")
	tag_array.add("tbody")
	tag_array.add("tr")
	tag_array.add("td")
	tag_array.add("col")
	tag_array.add("colgroup")
	tag_array.add("li")
	tag_array.add("ul")
	tag_array.add("strike")
	tag_array.add("iframe")
	tag_array.add("input")
	tag_array.add("u")
	
	tag_count	:= tag_array.length()
	
	loop % tag_count
	{
		content	:= content.replace("<" . tag_array.get(a_index) . ">", "")
		content	:= content.replace("</" . tag_array.get(a_index) . ">", "")
		content	:= content.replace("<" . tag_array.get(a_index).toUpperCase() . ">", "")
		content	:= content.replace("</" . tag_array.get(a_index).toUpperCase() . ">", "")
	}
	
	is_tag_exist	:= true
	
	while(is_tag_exist == true)
	{
		loop % tag_count
		{
			current_tag		:= tag_array.get(a_index)
			
			if(content.isExist("<" . current_tag) || content.isExist("<" . current_tag.toUpperCase()))
			{
				content 	:= content.replace("<" . current_tag . content.getContentBetween("<" . current_tag, ">") . ">", "")
				content 	:= content.replace("<" . current_tag.toUpperCase() . content.getContentBetween("<" . current_tag.toUpperCase(), ">") . ">", "")
			}
		}
		
		is_tag_exist	:= false
		
		loop % tag_count
		{
			current_tag		:= tag_array.get(a_index)
			
			if(content.isExist("<" . current_tag) || content.isExist("<" . current_tag.toUpperCase()))
			{
				is_tag_exist	:= true
			}
		}
	}
	
	if(content.isExist("<SCRIPT") || content.isExist("<script"))
	{
		content		:= content.replace("<SCRIPT" . content.getContentBetween("<SCRIPT", "</SCRIPT>") . "</SCRIPT>", "")
		content		:= content.replace("<script" . content.getContentBetween("<script", "</script>") . "</script>", "")
	}
	
	
	return content
}
string_underbarToCamel(this){
	underbar			:= this
	camel				:= ""
	upper_flag			:= false

	stringLower, underbar, underbar

	loop, parse, underbar
	{
		if(a_loopfield == "_")
		{
			upper_flag := true
		}
		else
		{
			if(upper_flag == true)
			{
				stringUpper, a_loopfieldUpper, a_loopfield
				upper_flag := false

				camel .= a_loopfieldUpper
			}
			else
			{
				camel .= a_loopfield
			}
			
		}
	}

	return camel
}
string_camelToUnderbar(this){
	camel				:= this
	underbar			:= ""
	

	head_piece := new String(SubStr(camel, "1", "1"))

	if(head_piece.isUpperCase())
	{
		return camel
	}

	loop, parse, camel
	{
		if((asc(a_loopfield) >= 65 && asc(a_loopfield) <= 90 && a_index != 1) || (asc(a_loopfield) >= 48 && asc(a_loopfield) <= 57))	; 대문자 혹은 숫자
		{
			underbar .=	"_" . a_loopfield
		}
		else
		{
			stringUpper, a_loopfieldUpper, a_loopfield
			underbar .=	a_loopfieldUpper
		}
	}

	return underbar
}
string_removeLeft(this, length){
	content		:= this
	
	return content.substring(length, content.length())
}
string_removeRight(this, length){
	content		:= this
	
	return content.substring(0, content.length() - length)
}
string_getPosition(this, needle, offset)	{                                         		; Returns the start of the needle. index starts at 0. Return -1 if not found.	
		content		:= this
		
		position	:= -1
		StringGetPos, position, content, %needle%, , offset
				
		return position
	}	
string_getPostPosition(this, needle, offset){                                        	; Returns the point after the end of the needle. Return -1 if not found.
	content		:= this
	position	:= -1

	StringGetPos, position, content, %needle%, , offset

	if(position == "-1")
		return -1
	else
		return position + strlen(needle)
}
string_getPreLetter(this, needle){                                                        	; Return the first character of needle
	content := this
	
	start_position := content.getPosition(needle, 0)
	if(start_position != "-1" && start_position != "0" )
		return substr(content, start_position, 1)
	else
		return ""
}
string_isVarExist(this, needle){
	content	:= this
		
	found_flag := false

	if(content.isExist(needle) == false){
		return false
	}
	
	pre_letter	:= content.getPreLetter(needle)
	post_letter := content.getPostLetter(needle)
	
	if(pre_letter.isVarLetter() == false && post_letter.isVarLetter() == false)
	{
		return true
	}



}
string_getPostLetter(this, needle){                                                      	; Return the back character of needle
	content := this
	
	post_position := content.getPostPosition(needle, 0)
	if(post_position != "-1")
		return substr(content, post_position + 1, 1)
	else
		return ""		
}
string_isVarLetter(this)	{                                                                       	; Make sure it is a string that can be a variable (alphanumeric, underbar)
		content := this
		
		if(content.isAlphabet() || content.isNumber() || content == "_")
			return true
		else
			return false
	}
	
	
	
