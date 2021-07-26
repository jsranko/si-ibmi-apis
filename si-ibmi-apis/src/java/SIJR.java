package src.java;

import java.util.regex.Pattern;

public class SIJR {

	public static int matches (String pattern, String text) {
		
		if (Pattern.matches(pattern, text)) {
			return 1;
		} else {
			return 0;
		}
	}
}
