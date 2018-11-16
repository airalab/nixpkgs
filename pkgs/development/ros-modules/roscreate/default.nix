{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "roscreate";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1gv9hka3mdrmigzznwbpbcgp2mdjfj2ya1y71yzq7smmm2flypqq";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "";
    homepage = http://wiki.ros.org/roscreate;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
