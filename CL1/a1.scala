

object Test{
  
  def main(args: Array[String])
  {
  	//Read the count of elements.
  	println("Enter the List count: ");
  	var count1=Console.readInt;
  	var list = new Array[Int](count1)
  	
  	//Read the elements.
  	for(a <- 0 to (count1-1))
 	{
 		println("Enter the List element "+ (a+1));
  		list(a)=Console.readInt;
  	}
  	
  	//Sort the list using Quicksort.
  	scala.util.Sorting.quickSort(list)
  	println("\n\n");
  	for(a <- 0 to (count1-1))
 		println("Element: "+ (a+1) + " ---->  "+ list(a));
  	
 	println("\n\nEnter element to search : ");
  	var j = Console.readInt;
  	var i = binarySearchIterative(list, j);
  	var k = binarySearchRecursive(list, 0, (count1-1), j);
  	if(i== (-1) && k== (-1))
    		println("\nElement Not Found");
  	else
    		println("\nElement found at position "+ (i+1));
  }

def binarySearchIterative(list: Array[Int], target: Int) : Int = {
  var left = 0;
  var right = list.length-1;
  while(left <= right)
  {
    val mid = left + (right-left)/2;
    // If the element is present at the middle itself
    if(list(mid)==target)
      return mid;
      
    // If element is smaller than mid, then it can only be present in left subarray
    else if (list(mid)>target)
      right = mid - 1;
      
    // Else the element can only be present in right subarray
    else
      left = mid + 1;
  }
  
  // We reach here when element is not present in array
  -1
}

def binarySearchRecursive(list: Array[Int], l: Int, r: Int, target: Int) : Int ={
	
	if (r >= l)
   	{
        val mid = l + (r - l)/2;
 
        // If the element is present at the middle itself
        if (list(mid) == target)  
        	return mid;
 
        // If element is smaller than mid, then it can only be present in left subarray
        if (list(mid) > target) 
        	return binarySearchRecursive(list, l, mid-1, target);
 
        // Else the element can only be present in right subarray
        return binarySearchRecursive(list, mid+1, r, target);
    }
 
   // We reach here when element is not present in array
   -1;
}

}
