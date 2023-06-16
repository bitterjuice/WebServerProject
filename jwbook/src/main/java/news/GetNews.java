package news;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class GetNews
 */
@WebServlet("/news/main")
public class GetNews extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String apiKey = "655198a455f34f3fbe7d097928adf883";
    private static final String apiUrl = "https://newsapi.org/v2/top-headlines?country=kr&category=";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetNews() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		String view = "";
		
		if(action == null) {
			getServletContext().getRequestDispatcher("/main?action=general").forward(request, response);
		} else {
			switch(action) {
				case "general": view = getNews(request, response, action); break;
				case "entertainment" : view = getNews(request, response, action); break;
				case "technology" : view = getNews(request, response, action); break;
				case "science" : view = getNews(request, response, action); break;
				case "sports" : view = getNews(request, response, action); break;
			}
			getServletContext().getRequestDispatcher("/news/"+ view).forward(request, response);
		}		
	}
	
//	public String getNews(HttpServletRequest request, HttpServletResponse response, String category) {
//		List<News> newsList = new ArrayList<News>();
//		try {	
//			URL url = new URL(apiUrl + category);
//			HttpURLConnection con = (HttpURLConnection)url.openConnection();
//			con.setRequestMethod("GET");
//			con.setRequestProperty("Content-type", "application/json");
//			con.setRequestProperty("X-Api-Key", apiKey);
//			con.setDoOutput(true);
//		
//			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//			StringBuilder sb = new StringBuilder();
//			String line = null;
//			
//			while((line  = br.readLine()) != null) {
//				sb.append(line);
//				}
//			
//			JSONObject responseJson = new JSONObject(sb.toString());
//			JSONArray temp = responseJson.getJSONArray("articles");
//			
//			for(int i = 0 ; i < temp.length() ; i++) {
//				JSONObject obj = temp.getJSONObject(i);
//				News news = new News();
//				news.setTitle(obj.getString("title"));
//				news.setUrl(obj.getString("url"));
//				NewsDAO newsdao = new NewsDAO();
////				newsdao.insertNews(obj.getString("title"),obj.getString("url"));
//				newsList.add(news);
//			}
//			
//			request.setAttribute("news", newsList);
//			} catch(Exception e) {
//		}
//
//		return "main.jsp";
//	}
	public String getNews(HttpServletRequest request, HttpServletResponse response, String category) {
	    List<News> newsList = new ArrayList<News>();
	    try {    
	        URL url = new URL(apiUrl + category);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("GET");
	        con.setRequestProperty("Content-type", "application/json");
	        con.setRequestProperty("X-Api-Key", apiKey);
	        con.setDoOutput(true);
	    
	        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        StringBuilder sb = new StringBuilder();
	        String line = null;
	        
	        while((line  = br.readLine()) != null) {
	            sb.append(line);
	        }
	        
	        JSONObject responseJson = new JSONObject(sb.toString());
	        JSONArray temp = responseJson.getJSONArray("articles");
	        
	        NewsDAO newsdao = new NewsDAO(); // NewsDAO 인스턴스 생성
	       

	        for(int i = 0 ; i < temp.length() ; i++) {
	            JSONObject obj = temp.getJSONObject(i);
	            String title = obj.getString("title");
	            String url1 = obj.getString("url");
	            News news = new News();
                news.setTitle(obj.getString("title"));
				news.setUrl(obj.getString("url"));
//                newsList.add(news);
	            if (!newsdao.isNewsTitleExists(title,category)) {
	                newsdao.insertNews(title, url1,category);
	            } else {
//	                System.out.println("News with title '" + title + "' already exists. Skipping insertion.");
	            }
	        }
	        
	        request.setAttribute("news", newsList);
	    } catch(Exception e) {
	        e.printStackTrace();
	    }

	    return "main.jsp";
	}

}
