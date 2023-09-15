package xersoc;

import java.lang.reflect.Method;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Attr;
import org.w3c.dom.Comment;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;

public class Main /*extends ConfigParser*//* implements ConfigSchema */{ 

    public static void main(String[] args) throws Exception{
		new Main().parseConfig(args[0]);
   }

   public void parseConfig(String config) throws Exception {
      System.out.println("laoded? " + config);
      config = config.replaceAll("^/+","/");
      Document document;
      try {
         document = createDocumentBuilder().parse(config);
      } catch (Exception e) {
         throw new IllegalStateException(e);
      }
   	 System.err.println("loaded! " + config);
  }

   protected DocumentBuilder createDocumentBuilder() throws ParserConfigurationException {
      DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
      documentBuilderFactory.setNamespaceAware(true);
      return documentBuilderFactory.newDocumentBuilder();
   }
}
