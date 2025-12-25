project('complex-networks-project', 'cpp',
  version : '1.0.0',
  default_options : ['warning_level=3',
                     'cpp_std=c++14'])

# Find OMNeT++ installation
omnetpp_root = get_option('omnetpp_root')
if omnetpp_root == ''
  omnetpp_root = '/space/jupiter/tools/omnetpp-6.3.0'
endif

# OMNeT++ include directories
omnetpp_inc = include_directories(
  omnetpp_root / 'include',
  'include'
)

# OMNeT++ libraries and linking
omnetpp_lib_dir = omnetpp_root / 'lib'
cpp_args = ['-fPIC']
link_args = [
  '-L' + omnetpp_lib_dir,
  '-Wl,-rpath,' + omnetpp_lib_dir,
  '-Wl,--no-as-needed',
  '-loppmain',
  '-loppsim',
  '-loppenvir', 
  '-loppcmdenv',
  '-loppqtenv',
  '-lopplayout',
  '-loppcommon'
]

# Source files
cpp_sources = [
  'src/tsn_node.cpp',
  'src/arbitrary_election.cpp', 
  'src/anonymous_election.cpp',
  'src/messages_m.cc'  # Generated message implementation
]

# Main executable
exe = executable('complex-networks-project',
  cpp_sources,
  include_directories : omnetpp_inc,
  cpp_args : cpp_args,
  link_args : link_args,
  dependencies : []
)

# Custom target for cleaning build files  
run_target('clean-all',
  command : ['rm', '-rf', 'build/']
)

# Custom target for running simulation
run_target('run-gui',
  command : ['./run.sh', 'gui', 'RingNetwork']
)

run_target('run-cmd', 
  command : ['./run.sh', 'cmd', 'RingNetwork']
)