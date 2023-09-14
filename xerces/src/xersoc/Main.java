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
      Document document;
      try {
         document = createDocumentBuilder().parse(config);
      } catch (Exception e) {
         throw new IllegalStateException(e);
      }
   	 System.out.println("laoded?");
   	 System.err.println("loaded!");
  }

   protected DocumentBuilder createDocumentBuilder() throws ParserConfigurationException {
   	 System.out.println("JEDU?");
   	 System.err.println("JEDU?");
      DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
      documentBuilderFactory.setValidating(false);
      //documentBuilderFactory.setFeature("http://xml.org/sax/features/external-parameter-entities", false); // it doesn't work
      documentBuilderFactory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
      documentBuilderFactory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
      documentBuilderFactory.setFeature("http://xml.org/sax/features/external-general-entities", false);
      documentBuilderFactory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
      //documentBuilderFactory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
      documentBuilderFactory.setNamespaceAware(true);
      return documentBuilderFactory.newDocumentBuilder();
   }
}
