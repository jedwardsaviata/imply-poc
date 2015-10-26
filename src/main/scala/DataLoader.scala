
object DataLoader {
  def main(args: Array[String]): Unit = {
    println("Arrrrrrrrg my byties!")


    // ===== BELOW IS FROM THE EXAMPLES ON GITHUB =====

    al indexService = "overlord" // Your overlord's druid.service, with slashes replaced by colons.
    val firehosePattern = "druid:firehose:%s" // Make up a service pattern, include %s somewhere in it.
    val discoveryPath = "/druid/discovery" // Your overlord's druid.discovery.curator.path.
    val dataSource = "foo"
    val dimensions = Seq("bar", "qux")
    val aggregators = Seq(new CountAggregatorFactory("cnt"), new LongSumAggregatorFactory("baz", "baz"))

    // Tranquility needs to be able to extract timestamps from your object type (in this case, Map<String, Object>).
    val timestamper = (eventMap: Map[String, Any]) => new DateTime(eventMap("timestamp"))

    // Tranquility needs to be able to serialize your object type. By default this is done with Jackson. If you want to
    // provide an alternate serializer, you can provide your own via ```.objectWriter(...)```. In this case, we won't
    // provide one, so we're just using Jackson:
    val druidService = DruidBeams
      .builder(timestamper)
      .curator(curator)
      .discoveryPath(discoveryPath)
      .location(DruidLocation(indexService, firehosePattern, dataSource))
      .rollup(DruidRollup(SpecificDruidDimensions(dimensions), aggregators, QueryGranularity.MINUTE))
      .tuning(
        ClusteredBeamTuning(
          segmentGranularity = Granularity.HOUR,
          windowPeriod = new Period("PT10M"),
          partitions = 1,
          replicants = 1
        )
      )
      .buildService()

    // Build a sample event to send; make sure we use a current date
    val obj = Map("timestamp" -> new DateTime().toString, "bar" -> "barVal", "baz" -> 3)

    // Send events to Druid:
    val numSentFuture: Future[Int] = druidService(Seq(obj))

    // Wait for confirmation:
    val numSent = Await.result(numSentFuture)
  }
}
