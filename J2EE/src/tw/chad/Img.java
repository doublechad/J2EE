package tw.chad;

import java.util.ArrayList;

public class Img {
	private String url;
	private String description;
	public Img(String url,String description) {
		this.url=url;
		this.description=description;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}
