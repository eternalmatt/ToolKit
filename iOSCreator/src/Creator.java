import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;



public class Creator 
{	
	
	public static void main(String[] args)
	{
		try {
			String fileName = "/Users/msenn2/Dropbox/Toolkit/Xcode/ToolKit/ToolKit/ToolKit-Info.plist";
			BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));
			writer.write(createFile());
			writer.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		}
		
		System.out.println("File written");
	}
	
	public static String createFile()
	{
		StringBuilder file = null;
		file = new StringBuilder(startFile());
		file.append(mainContents());
		file.append(makeKeyAndValue("UploadButtonText", 		"Upload to Campaign"));
		file.append(makeKeyAndValue("ActionButtonStartText", 	"Start capture"));
		file.append(makeKeyAndValue("ActionButtonStopText", 	"Stop capture"));
		file.append(makeKeyAndValue("ShowMapButtonText", 		"Show map"));
		file.append(makeKeyAndValue("CameraButtonText", 		"Take a pic!"));
		file.append(makeKeyAndValue("AlertWindowSuccessTitle",	"Success!"));
		file.append(makeKeyAndValue("AlertWindowSuccessBody", 	"Your photo has been uploaded."));
		file.append(makeArrayFromStrings("TextInputTextBoxes", 
				new String[]{"Text Input box one", "Text Input box two"}));
		file.append(makeArrayFromStrings("Sensors", 
				new String[]{"Acceleration", "Camera", "Location", "TextInput"}));
		
		
		return file.append(endFile()).toString();
	}
	
	private static StringBuilder makeKeyAndValue(String key, String value)
	{
		return new StringBuilder("<key>")
						 .append(key)
						 .append("</key><string>")
						 .append(value)
						 .append("</string>");
	}
	
	private static StringBuilder makeArrayFromStrings(String key, String[] strings)
	{
		StringBuilder array = new StringBuilder("<key>" + key + "</key>" + "<array>");
		
		for(String string : strings)
			array.append("<string>" + string + "</string>");
		
		array.append("</array>");
		
		return array;
	}
	
	private static String startFile()
	{
		return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
				"<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\"" +
				" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" +
				"<plist version=\"1.0\"><dict>";
	}
	
	private static String mainContents()
	{
		return "<key>CFBundleDevelopmentRegion</key>" +
				"<string>en</string>" +
				"<key>CFBundleDisplayName</key>" +
				"<string>${PRODUCT_NAME}</string>" +
				"<key>CFBundleExecutable</key>" +
				"<string>${EXECUTABLE_NAME}</string>" +
				"<key>CFBundleIconFiles</key>" +
				"<array/>" +
				"<key>CFBundleIdentifier</key>" +
				"<string>edu.uncc.cci.${PRODUCT_NAME:rfc1034identifier}</string>" +
				"<key>CFBundleInfoDictionaryVersion</key>" +
				"<string>6.0</string>" +
				"<key>CFBundleName</key>" +
				"<string>${PRODUCT_NAME}</string>" +
				"<key>CFBundlePackageType</key>" +
				"<string>APPL</string>" +
				"<key>CFBundleShortVersionString</key>" +
				"<string>1.0</string>" +
				"<key>CFBundleSignature</key>" +
				"<string>????</string>" +
				"<key>CFBundleVersion</key>" +
				"<string>1.0</string>" +
				"<key>LSRequiresIPhoneOS</key>" +
				"<true/>" +
				"<key>UIRequiredDeviceCapabilities</key>" +
				"<array>" +
				"<string>armv7</string>" +
				"</array>" +
				"<key>UISupportedInterfaceOrientations</key>" +
				"<array>" +
				"<string>UIInterfaceOrientationPortrait</string>" +
				"<string>UIInterfaceOrientationLandscapeLeft</string>" +
				"<string>UIInterfaceOrientationLandscapeRight</string>" +
				"</array>" +
				"<key>UISupportedInterfaceOrientations~ipad</key>" +
				"<array>" +
				"<string>UIInterfaceOrientationPortrait</string>" +
				"<string>UIInterfaceOrientationPortraitUpsideDown</string>" +
				"<string>UIInterfaceOrientationLandscapeLeft</string>" +
				"<string>UIInterfaceOrientationLandscapeRight</string>" +
				"</array>";
	}
	
	private static String endFile()
	{
		return "</dict></plist>";
	}
	


}
