/**
 *
 * Use this query to get source values, and output to a .rpt file...strip header and footer
 * SELECT
 [PassageId]
 ,[ItemID]
 ,[AbilityAttributeID]
 ,[SegmentId]
 ,[Sequence]
 ,[Score]
 FROM [Pennsylvania_idb_550679_0_sqa].[dbo].[ItemScore]
 where TicketID = 1886665764
 order by Cast(Sequence as int) asc
 */
File inFile = new File("c:/tmp/queryResults/rescore_pa.rpt")
inFile.eachLine { line ->
    tokens = line.split()
    println "<tes:StudentResponse sequence=\"${tokens[4]}\" passageID=\"${tokens[0]}\" itemID=\"${tokens[1]}\" " +
            "abilityAttributeID=\"${tokens[2]}\" segmentID=\"${tokens[3]}\" scorePoints=\"${tokens[5]}\"/>"
}
return ""