<%@page import="java.util.*"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.management.MemoryPoolMXBean"%>
<%@page import="java.lang.management.MemoryUsage"%>
<%@page import="java.lang.Math.*"%>

<%
   int iteratorValue = 20;
		System.out.println("\n=================> OOM test started..\n");
		for (int outerIterator = 1; outerIterator < 20; outerIterator++) {
		double usedPercent=(double)(Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())/Runtime.getRuntime().maxMemory()*100;
		    System.out.println("UsedPercent:" + usedPercent);
			if (usedPercent >= 75) {
			out.println("UsedPercent reached limit:" + usedPercent);
			break;
			}
			System.out.println("Iteration " + outerIterator + " Free Mem: " + Runtime.getRuntime().freeMemory());
			int loop1 = 2;
			if (usedPercent >= 50) {
			iteratorValue = 20971520;
			}
			
			int[] memoryFillIntVar = new int[iteratorValue];
			
			// feel memoryFillIntVar array in loop..
			do {
				memoryFillIntVar[loop1] = 0;
				loop1--;
			} while (loop1 > 0);
			iteratorValue = iteratorValue * 5;
			System.out.println("\nRequired Memory for next loop: " + iteratorValue);
			Thread.sleep(10000);
		}
 response.setIntHeader("Refresh", 5);
%>

<%
	double usedPercent=(double)(Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())/Runtime.getRuntime().maxMemory()*100;
	out.println("UsedPercent:" + usedPercent);
%>