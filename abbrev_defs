;;-*-coding: utf-8;-*-
(define-abbrev-table 'global-abbrev-table
  '(
    ("cd" "// TODO(cditzel MB):" nil :count 0)
    ("cla_csft" "--processors=LidarToRadarProcessor
--targetJson=lidar:gt:top:p128:v4p5;$CSFT_INPUT_PATH/dataset-structured.sqlite --rig=/home/ubuntu/git-ndas/ndas/nv/datasets/2dbf6282-b531-11eb-9c5e-00044baf74dc/rig_dynamic_calibration.json --disableSensorsByType=camera,time --disableSensorsByName=uss:valeo,lidar:parking:gt:front:p128,lidar:parking:gt:left:p128,lidar:parking:gt:rear:p128,lidar:parking:gt:right:p128,lidar:front:center:p128:v4p5,lidar:front:center:p128,radar:cross:left,radar:cross:right,radar:rear:left,radar:rear:right,radar:side:left,radar:side:right,time:nvpps:main:a,time:nvpps:main:b,can:1 --offscreen=1" nil :count 0)
    ("cla_exp" "--outputFolder=nv --rig=/home/ubuntu/git-ndas/ndas/nv/datasets/2dbf6282-b531-11eb-9c5e-00044baf74dc/rig_dynamic_calibration.json" nil :count 0)
    ("csft" "bazel-bin/tools/experimental/lidarperception/crossSensorFusionTool/tools_experimental_cross_sensor_fusion" nil :count 0)
    ("ex" "exit(1);" nil :count 0)
    ("expo" "bazel-bin/tools/experimental/lidarperception/lidarExporterTool/lidar_exporter_tool" nil :count 0)
    ("fr" "for(int i = 0; i < @@; ++i){}" nil :count 0)
    ("os" "std::cout << @@ << \"\\n\";" nil :count 0)
    ("pr" "printf(\"%d\\n\", @@);" nil :count 0)
    ("rr" "- [ ]" nil :count 0)
    ("vo" "(void) @@;" nil :count 0)
   ))

