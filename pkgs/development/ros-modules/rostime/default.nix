{ lib
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
}:

let
  pname = "rostime";
  version = "0.6.7";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0bk1sw3ydlxp070kvpkd2ma36ida521awgvr3np8nwzyqvdzrqd9";
  };

  propagatedBuildInputs = [ catkin cpp_common ];

  meta = with lib; {
    description = "Time and Duration implementations for C++ libraries";
    homepage = http://wiki.ros.org/rostime;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
