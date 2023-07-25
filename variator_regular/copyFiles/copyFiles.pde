import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

void setup() {
  // Replace these paths with your actual file paths
  println(sketchPath());
  String sourceFilePath = sketchPath("variations/pop_000/indiv_000/indiv_000.pde");
  String destinationFolderPath = sketchPath("favourites");

  // Call the function to copy the file
  boolean success = copyFile(sourceFilePath, destinationFolderPath);

  if (success) {
    println("File copied successfully!");
  } else {
    println("File copy failed.");
  }

  // Exit the application
  exit();
}

boolean copyFile(String sourceFilePath, String destinationFolderPath) {
  try {
    // Create File instances for source file and destination folder
    File sourceFile = new File(sourceFilePath);
    File destinationFolder = new File(destinationFolderPath);

    // Check if the source file exists
    if (!sourceFile.exists()) {
      println("Source file does not exist.");
      return false;
    }

    // Check if the destination is a directory
    if (!destinationFolder.isDirectory()) {
      println("Destination is not a valid folder.");
      return false;
    }

    // Get the filename from the source file path
    String filename = sourceFile.getName();

    // Create Path instances for source and destination
    Path sourcePath = Paths.get(sourceFilePath);
    Path destinationPath = Paths.get(destinationFolderPath + filename);

    // Copy the file to the destination folder
    Files.copy(sourcePath, destinationPath);

    return true;
  } catch (IOException e) {
    println("Error copying file: " + e.getMessage());
    return false;
  }
}
