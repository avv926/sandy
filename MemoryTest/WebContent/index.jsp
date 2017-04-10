<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.management.MemoryPoolMXBean"%>
<%@page import="java.lang.management.MemoryUsage"%>
<%@page import="java.lang.management.MemoryMXBean"%>


<%!

    public String dumpUsage (MemoryUsage usage) {
        StringBuffer buf = new StringBuffer();
        buf.append ("<table>");
        buf.append ("<tr>");
        buf.append ("<td>Committed</td>");
        buf.append ("<td>" + usage.getCommitted() + "</td>");
        buf.append ("</tr>");
        buf.append ("<tr>");
        buf.append ("<td>Init</td>");
        buf.append ("<td>" + usage.getInit() + "</td>");
        buf.append ("</tr>");
        buf.append ("<tr>");
        buf.append ("<td>Max</td>");
        buf.append ("<td>" + usage.getMax() + "</td>");
        buf.append ("</tr>");
        buf.append ("<tr>");
        buf.append ("<td>Used</td>");
        buf.append ("<td>" + usage.getUsed() + "</td>");
        buf.append ("</tr>");
        buf.append ("</table>");
        return buf.toString();
    }
%>
<%
    MemoryMXBean memBean = ManagementFactory.getMemoryMXBean();
    out.println ("[<b>JVM</b>]<hr>");
    out.println ("[<b>Heap usage</b>]<br>");
    out.println (dumpUsage (memBean.getHeapMemoryUsage()));
    out.println ("[<b>Non Heap usage</b>]<br>");
    out.println (dumpUsage (memBean.getNonHeapMemoryUsage()));
    out.println ("Objects pending finalization:" + memBean.getObjectPendingFinalizationCount());
    out.println ("<br><br>[<b>POOLS</b>]<hr>");
    List<MemoryPoolMXBean> beans = ManagementFactory.getMemoryPoolMXBeans();

    for (MemoryPoolMXBean memPoolBean:beans) {
        out.println ("<br>[<b>" + memPoolBean.getName() + "</b>]<br>");
        out.println ("type:" + memPoolBean.getType() + "<br>");
        //out.println ("CollectionUsageThreshold:" + memPoolBean.getCollectionUsageThreshold() + "<br>");
        //out.println ("CollectionUsageThresholdCount:" + memPoolBean.getCollectionUsageThresholdCount() + "<br>");
        //out.println ("UsageThreshold:" + memPoolBean.getUsageThreshold() + "<br>");
        //out.println ("UsageThresholdCount:" + memPoolBean.getUsageThresholdCount() + "<br>");
        MemoryUsage usage = memPoolBean.getPeakUsage();
        out.println ("Peak Usage<br>");
        out.println (dumpUsage (usage));
        usage = memPoolBean.getUsage();
        out.println ("Current Usage<br>");
        out.println (dumpUsage (usage));
    }
    
    int mb = 1024*1024;
         
        //Getting the runtime reference from system
        Runtime runtime = Runtime.getRuntime();
        out.println ("<br>");
        out.println ("[<b>Heap usage summary in MB</b>]<br>");
        out.println ("<hr>");
         
        //Print used memory
        out.println("Used Memory:"
            + (runtime.totalMemory() - runtime.freeMemory()) / mb);
        out.println ("<br>");
        //Print free memory
        out.println("Free Memory:"
            + runtime.freeMemory() / mb);
       out.println ("<br>");  
        //Print total available memory
        out.println("Total Memory:" + runtime.totalMemory() / mb);
       out.println ("<br>");
        //Print Maximum available memory
        out.println("Max Memory:" + runtime.maxMemory() / mb);
        double usedPercent=(double)(Runtime.getRuntime().totalMemory() -Runtime.getRuntime().freeMemory())/Runtime.getRuntime().maxMemory();
        out.println ("<br>");
        out.println("Used Percent :" + (usedPercent)*100);
        out.println ("<br>");
        out.println ("<br>");
        response.setIntHeader("Refresh", 5);
%>

<FORM action="memoryeater.jsp"><INPUT type=submit value="usememory"><a
href="memoryeater.jsp" ></a></FORM>
