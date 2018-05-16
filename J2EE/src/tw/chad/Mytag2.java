package tw.chad;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class Mytag2 extends SimpleTagSupport{
	private String text;
	@Override
	public void doTag() throws JspException, IOException {
		super.doTag();
		getJspContext().getOut().print(text);;
	}
	public void setText(String text) {
		this.text=text;
	}
}
