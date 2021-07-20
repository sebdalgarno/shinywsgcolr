library(subfoldr2)
detection <- readRDS("tests/data/detection.rds")
detection_path <- readRDS("tests/data/detection_path.rds")
deployment <- readRDS("tests/data/deployment.rds")
station <- readRDS("tests/data/station.rds")
reference_locations<- readRDS("tests/data/reference_locations.rds")
river <- readRDS("tests/data/river.rds")

devtools::load_all()
run_app(detection = detection, detection_path = detection_path,
        deployment = deployment, station = station, river = river,
        reference_locations = reference_locations)
