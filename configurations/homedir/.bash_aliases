# .bashrc

export ATRIA=/usr/atria

if [ -z $ENVCT ] ; then
    PS1='\n[\h] \u\n\w > '
else
    # Commandes pour ClearCase
    PS1='\n[\h] \u (`ct pwv -s`)\n\w > '
    PATH=$PATH:$ATRIA/bin
    PATH=$PATH:/projet/SAF3K/MCR/RTOS/hardhat/devkit/ppc/8xx/bin
    res=$(echo $PATH | grep atria | wc -l)
    if [ $res -eq 0 ]
    then
	export PATH=$PATH:$ATRIA/bin:~:/home/ccaseadm/scripts
    fi
    umask 022
    export VOB_RSRCU='/vobs/SS_RSRCU'
    export VOB_PGS='/vobs/SS_PGS'
    export RS_ROOT=$VOB_RSRCU/RS
    export PGS_ROOT=$VOB_PGS/PGS
    alias ct=cleartool
    alias xcc=xclearcase
    alias setview_rsdev='ENVCT=set VIS=no cleartool setview ablangy_dev'
    alias setview_rsint='ENVCT=set VIS=no cleartool setview ablangy_int'
    alias setview_rsVer='ENVCT=set VIS=no cleartool setview rsrculoc1_view'
    alias setview_visdev='ENVCT=set VIS=yes cleartool setview abl_vis_dev'
    alias setview_visint='ENVCT=set VIS=yes cleartool setview abl_vis_int'
    alias setview_visVer='ENVCT=set VIS=yes cleartool setview visloc1_view'
    alias setview_bssdev='ENVCT=set VIS=no cleartool setview abl_bss2_dev'
    alias setview_pgsInt='ENVCT=set VIS=no cleartool setview abl_pgs_int'
    alias setview_pgsVer='ENVCT=set VIS=no cleartool setview pgsloc1_view'
    alias setview_rsmDev='ENVCT=set VIS=no cleartool setview abl_rs_dev'
    alias setview_rsmInt='ENVCT=set VIS=no cleartool setview abl_rs_int'
    alias setview_rsmLiv='ENVCT=set VIS=no cleartool setview abl_rs_liv'
    alias lsvob='ct lsvob'
    alias lsview='ct lsview'
    alias pwv='ct pwv'
    alias lsco='ct lsco -me -r -s -cvi'
    alias lsvtree='ct lsvtree'

    if [ ! -z $VIS ] ; then
	if [ $VIS == "yes" ] ; then
	    alias cdvis='cd $RS_ROOT/RCU/RCUIntVIS/SRC'
	fi
    fi

    alias cdrcu='cd $RS_ROOT/RCU'
    alias cdelmer='cd $RS_ROOT/RCU/RCUIntElmer/SRC'
    alias cdinband='cd $RS_ROOT/RCU/RCUIntInBand/SRC'
    alias cdpk='cd $RS_ROOT/RCU/RCUIntParkAir3000/SRC'
    alias cdpio='cd $RS_ROOT/RCU/RCUIntPio/SRC'
    alias cdrmids='cd $RS_ROOT/RCU/RCUIntRmids/SRC'
    alias cdxk='cd $RS_ROOT/RCU/RCUIntRSXK2100/SRC'
    alias cdopto='cd $RS_ROOT/RCU/RCUIntOpto/SRC'
    alias cdrcuappli='cd $RS_ROOT/RCU/RCUAppli/SRC'
    alias cdrcuconfig='cd $RS_ROOT/RCU/RCUConfig/SRC'
    alias cdrcumsg='cd $RS_ROOT/RCU/RCUMsg/SRC'
    alias cdrcuswitch='cd $RS_ROOT/RCU/RCUSwitch/SRC'
    alias cd400='cd $RS_ROOT/RCU/RCUIntRs400/SRC'
    alias cdmulti='cd $RS_ROOT/RCU/RCUIntMultifono/SRC'
    alias cdocm='cd $RS_ROOT/OCM'
    alias cdeos='cd $RS_ROOT/EOS/SRC'
    alias cdrs='cd $RS_ROOT'
    alias cdpgs='cd $PGS_ROOT'
    alias cddsp='cd $RS_ROOT/DRVDSP/Dev/SRC'
    alias cdfpga='cd $RS_ROOT/DRVFPGA/Dev/SRC'
    alias cdgip='cd $RS_ROOT/GIP/'
    alias cdgiprouted='cd $RS_ROOT/GIP/GIPRouted/SRC'
    alias cdasm='cd $RS_ROOT/ASM'
    alias cdm3sr='cd $RS_ROOT/RCU/RCUIntRSM3SR/SRC'
    alias cdgb2pp='cd $RS_ROOT/RCU/RCURSgb2pp/SRC'
    alias cdkofa='cd $RS_ROOT/RCU/RCUIntKOFAgw/SRC'
fi
      
export PS1 PATH

alias l='ls -F'
alias la='ls -aF'
alias ll='ls -lF'
alias lla='ls -laF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias m='more --raw-control-chars'
alias mman='man -P /bin/more'
alias git='LANG=en_US git'

export PATH=$PATH:/opt/cldk/bin

export WINEDITOR=emacs
export EDITOR=emacs

emacs ()
{

  EFILEDIR=`dirname "$1"`;

  if [ "#$EFILEDIR"=="#" ]; then
    EFILEDIR=`pwd`;
  fi

  /usr/bin/emacs "$@" --name "$EFILEDIR" -- 2>/dev/null

  return 0;
}

# ---------------------------------------------------------------------------
# Recherche des repertoires contenant les sources

# #####
# Recherche de repertoires en excluant .svn
findDirs ()
{
  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]] && [[ ! -d ./help ]]; then
    echo "HELP: Recherche de repertoires en excluant .svn";
    return 0;
  fi

  local jobdir="";
  local depth=0;
  if [ $# -lt 1 ]; then
    jobdir=`pwd`;
  else
      jobdir=$1;
      if [ $# -eq 2 ]; then
	  depth=$2;
      fi
  fi

  if [ ! -d $jobdir ]; then
    echo "Invalid directory";
    return 1;
  fi
  
  pushd $jobdir 1>/dev/null;
  jobdir=`pwd`;

  if [ $depth -eq 0 ]; then
      dirlst=`find $jobdir -type d ! -wholename '*/.svn*'`;
  else
      dirlst=`find $jobdir -type d -maxdepth $depth ! -wholename '*/.svn*' 2>/dev/null`;
  fi

  popd 1>/dev/null;
  
  # echo -n $dirlst;
}

# #####
# Recherche des repertoires SRC en excluant .svn et TEST*
findSrcDirs ()
{
  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]] && [[ ! -d ./help ]]; then
    echo "HELP: Recherche des repertoires SRC en excluant .svn et TEST*";
    return 0;
  fi

  local jobdir="";
  if [ $# -lt 1 ]; then
    jobdir=`pwd`;
  else
    jobdir=$1;
  fi

  if [ ! -d $jobdir ]; then
    echo "Invalid directory";
    return 1;
  fi
  
  pushd $jobdir 1>/dev/null;
  jobdir=`pwd`;
  
  dirlst=`find $jobdir -type d -name SRC ! -wholename '*/.svn*' ! -wholename '*/TEST*' 2>/dev/null;`

  popd 1>/dev/null;
  
  # echo $dirlst;  
}

# #####
# Recherche de repertoires en excluant .svn et TEST*
findDirsNotTest ()
{
  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]] && [[ ! -d ./help ]]; then
    echo "HELP: Recherche de repertoires en excluant .svn et TEST*";
    return 0;
  fi

  local jobdir="";
  local depth=0;
  if [ $# -lt 1 ]; then
    jobdir=`pwd`;
  else
      jobdir=$1;
      if [ $# -eq 2 ]; then
	  depth=$2;
      fi
  fi

  if [ ! -d $jobdir ]; then
    echo "Invalid directory";
    return 1;
  fi
  
  pushd $jobdir 1>/dev/null;
  jobdir=`pwd`;

  # local dirlst="";
  if [ $depth -eq 0 ]; then
      dirlst=`find $jobdir -type d ! -wholename '*/.svn*' ! -wholename '*/TEST*'`;
  else
      dirlst=`find $jobdir -type d -maxdepth $depth ! -wholename '*/.svn*' ! -wholename '*/TEST*'`;
  fi

  popd 1>/dev/null;

  # echo $dirlst;
}

# ---------------------------------------------------------------------------
# Les fonctions

# ####
# Attend une reponse Y/N
waitResponseYesNo ()
{
  local choix="rien";
  read response;

  if  [[ z"$response" == z"OUI" ]] || [[ z"$response" == z"oui" ]] || [[ z"$response" == z"o" ]] || [[ z"$response" == z"O" ]]; then
    choix="oui";
  elif [[ z"$response" == z"NON" ]] || [[ z"$response" == z"non" ]] || [[ z"$response" == z"n" ]] || [[ z"$response" == z"N" ]]; then
    choix="non";
  fi
  
  case $choix in
    oui)
    return 0;
    ;;
    non)
    return 1;
    ;;
    *)
    ;;
  esac

  echo "ERREUR votre choix n est pas 'oui' ou 'non'";
  return 2;
}
  
# #####
# grep dans les repertoires SRC
fsrcgrep ()
{
  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: grep dans les repertoires SRC";
    return 0;
  fi

  local dir="";
  findSrcDirs
  for dir in $dirlst; do
    if [[ $1 == -* ]]; then
      grep -n $1 -- "$2" $dir/* 2>/dev/null;
    else
      grep -n -- "$1" $dir/* 2>/dev/null;
    fi
  done

  return 0;
}

# #####
# grep dans les repertoires en excluant .svn
figrep ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: grep dans les repertoires en excluant .svn";
    return 0;
  fi

  local dir;
  findDirs
  local SAVE_IFS=$IFS
  IFS=$'\n'
  for dir in . $dirlst; do
    if [[ $1 == -* ]]; then
      grep -n $1 --with-filename -- "$2" $dir/* 2>/dev/null;
    else
      grep -n --with-filename -- "$1" $dir/* 2>/dev/null;
    fi
  done
  IFS=$SAVE_IFS

  return 0;
}

# #####
# Fonction interne de generation du cscope.files
mkCscopeList ()
{
    # find $@ -maxdepth 1 -type f -iname "*.c" \
    find $@ ! -wholename "*.svn/*" \( -type f -iname "*.c" \
	-o -type f -iname "*.h" \
	-o -type f -iname "*.cpp" \
	-o -type f -iname "*.hpp" \
	-o -type f -iname "*.cc" \
	-o -type f -iname "*.tpl" \
	-o -type f -iname "*.asm" \) >> cscope.tmp;

    # echo \-q > cscope.files;
    echo > cscope.files;
    while read line || [[ -n "$line" ]]; do echo "\"$line\"" >> cscope.tmp2; done <cscope.tmp
    sort -bd cscope.tmp2 >> cscope.files;
    rm -f cscope.tmp;
    rm -f cscope.tmp2;

    return 0;
}

# #####
# Function interne de generation du fichier TAGS
mkTagsDB ()
{
    if [ ! -f ./cscope.files ]; then
	mkCscopeList $@
    fi
    echo "."

    echo > TAGS.files;
    while read line || [[ -n "$line" ]]; do echo "$line" | sed -e 's/\"//g' -e 's/\(\s\)/\\\1/g' >> TAGS.files; done <cscope.files
    local filelist=`cat ./TAGS.files`;

    echo "Generating TAGS...";
    etags --members $filelist
    
    return 0;
}

# #####
# Effacement de la base etags du repertoire courant
cleanTags ()
{
  local pushdir=0;
  if [ $# -eq 1 ]; then
    if [ x"$1" == x"help" ]; then
      echo "HELP: Effacement de la base etags dans le repertoire courant";
      return 0;
    elif [ -d "$1" ]; then
      pushd "$1" 1>/dev/null;
      pushdir=1;
    else
      echo "$FUNCNAME: Invalid argument ""$1";
    return 1;
    fi
  fi
  
  local jobdir=`pwd`;
  if [ -f $jobdir/TAGS ]; then
    echo -n "$FUNCNAME: Cleaning etags in "$jobdir" ."
    rm -f $jobdir/TAGS 
    rm -f $jobdir/TAGS.files
    echo "."
  fi

  if [ $pushdir -eq 1 ]; then
    popd 1>/dev/null;
  fi
    
  return 0;
}

# #####
# Generation du fichier tags des fichiers sources situes dans des repertoires SRC en excluant .svn et /TEST*
mkSrcTags ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Generation du fichier tags des fichiers sources situes dans des repertoires SRC en excluant .svn et /TEST*";
    return 0;
  fi
  
  local srcdirlst="";
  local tgtdir="";
  for tgtdir in $@; do
      if [ ! -d $tgtdir ]; then
	  echo "$FUNCNAME: Invalid argument, $tgtdir is not a directory";
	  return 1;
      fi

      local jobdir=`pwd`;
      jobdir="$jobdir/$tgtdir";

      echo -n "$FUNCNAME: Building cscope in "$jobdir" ."
      findSrcDirs $jobdir;
      srcdirlst="$srcdirlst $dirlst";
  done

  mkTagsDB $srcdirlst;
  
  echo "$FUNCNAME: -- DONE --"

  return 0;
}

# #####
# Generation du fichier tags des fichiers sources situes dans des repertoires en excluant .svn et /TEST*
mkTags ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Generation du fichier tags des fichiers sources situes dans des repertoires en excluant .svn et /TEST*";
    return 0;
  fi
  
  if [ ! -d $1 ]; then
    echo "$FUNCNAME: Invalid argument, not a directory";
    return 1;
  fi

  pushd $1 1>/dev/null;
  local jobdir=`pwd`;

  cleanTags;

  findDirs;

  echo -n "$FUNCNAME: Building tags in "$jobdir" ."

  mkTagsDB $dirlst;

  popd 1>/dev/null;

  echo "$FUNCNAME: -- DONE --"

  return 0;
}

# #####
# Function interne de generation de la base cscope
mkCscopeDB ()
{
    mkCscopeList $@
    echo "."

    echo "Generating cscope database...";
    cscope -q -b -f cscope.out;
    
    return 0;
}

# #####
# Effacement de la base cscope dans le repertoire courant
cleanCscope ()
{
  local pushdir=0;
  if [ $# -eq 1 ]; then
    if [ x"$1" == x"help" ]; then
      echo "HELP: Effacement de la base cscope dans le repertoire courant";
      return 0;
    elif [ -d $1 ]; then
      pushd $1 1>/dev/null;
      pushdir=1;
    else
      echo "$FUNCNAME: Invalid argument";
    return 1;
    fi
  fi
  
  local jobdir=`pwd`;
  if [[ -f $jobdir/cscope.tmp ]] || [[ -f $jobdir/cscope.files ]] || [[ -f $jobdir/cscope.out ]] || [[ -f $jobdir/cscope.out.in ]] || [[ -f $jobdir/cscope.out.po ]]; then
    echo -n "$FUNCNAME: Cleaning cscope in "$jobdir" ."
    rm -f $jobdir/cscope.tmp;
    echo -n "."
    rm -f $jobdir/cscope.files;
    echo -n "."
    rm -f $jobdir/cscope.out;
    echo -n "."
    rm -f $jobdir/cscope.out.in;
    echo -n "."
    rm -f $jobdir/cscope.out.po;
    echo "."
  fi

  if [ $pushdir -eq 1 ]; then
    popd 1>/dev/null;
  fi
    
  return 0;
}

# #####
# Generation de la base cscope des fichiers sources situes dans des repertoires SRC en excluant .svn et /TEST*
mkSrcCscope ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Generation de la base cscope des fichiers sources situes dans des repertoires SRC en excluant .svn et /TEST*";
    return 0;
  fi
  
  local srcdirlst="";
  local tgtdir="";
  for tgtdir in $@; do
      if [ ! -d $tgtdir ]; then
	  echo "$FUNCNAME: Invalid argument, $tgtdir is not a directory\n";
	  return 1;
      fi

      local jobdir=`pwd`;
      jobdir="$jobdir/$tgtdir";

      echo "$FUNCNAME: Building cscope in "$jobdir" ."
      findSrcDirs $jobdir;
      if [ z"$srcdirlst" == z"" ]; then
	  srcdirlst=$dirlst;
      else
	  srcdirlst="$srcdirlst $dirlst";
      fi
  done

  echo -n "$FUNCNAME: Building cscope"
  mkCscopeDB $srcdirlst;

  echo "$FUNCNAME: -- DONE --"

  return 0;
}

# #####
# Generation de la base cscope des fichiers sources situes dans des repertoires en excluant .svn et /TEST*
mkCscope ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Generation de la base cscope des fichiers sources situes dans des repertoires en excluant .svn et /TEST*";
    return 0;
  fi

  if [ ! -d $1 ]; then
    echo "$FUNCNAME: Invalid argument, not a directory";
    return 1;
  fi

  local jobdir=`pwd`;

  cleanCscope;

  echo -n "$FUNCNAME: Building cscope in "$jobdir" ."
  mkCscopeDB $@;

  echo "$FUNCNAME: -- DONE --"
  
  return 0;
}

# #####
# Function interne de generation de la base Ebrowse
ablMkEbrowse ()
{
  local browsefile=$1;
  shift;

  local lst1=`find $@ -maxdepth 1 -type f -name "*.c"`
  echo -n "."
  local lst2=`find $@ -maxdepth 1 -type f -name "*.cc"`
  echo -n "."
  local lst3=`find $@ -maxdepth 1 -type f -name "*.cpp"`
  echo -n "."
  local lst4=`find $@ -maxdepth 1 -type f -name "*.h"`
  echo -n "."
  local lst5=`find $@ -maxdepth 1 -type f -name "*.hpp"`
  echo -n "."
  local lst6=`find $@ -maxdepth 1 -type f -name "*.tpl"`
  echo "."

  echo "Generating BROWSE...";
  ebrowse $lst1 $lst2 $lst3 $lst4 $lst5 $lst6 --output-file=$browsefile.ebrowse;

  return 0;
}

# #####
# Generation de la base Ebrowse des fichiers sources situes dans des repertoires en excluant .svn et /TEST*
mkSrcEbrowse ()
{
  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Generation de la base Ebrowse des fichiers sources situes dans des repertoires en excluant .svn et /TEST*";
    return 0;
  fi

  if [ ! -d $1 ]; then
    echo "$FUNCNAME: Invalid argument, not a directory";
    return 1;
  fi

  local filename="BROWSE";
  if [ $# -eq 2 ]; then
    filename="$2";
  fi

  pushd $1 1>/dev/null;
  local jobdir=`pwd`;

  echo -n "$FUNCNAME: Building Ebrowse in "$jobdir" ."
  findSrcDirs

  ablMkEbrowse "$filename" $dirlst;

  popd 1>/dev/null;

  echo "$FUNCNAME: -- DONE --"
  
  return 0;
}

# #####
# Generation de la base Ebrowse des fichiers sources situes dans des repertoires en excluant .svn et /TEST*
mkEbrowse ()
{
  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Generation de la base Ebrowse des fichiers sources situes dans des repertoires en excluant .svn et /TEST*";
    return 0;
  fi

  if [ ! -d $1 ]; then
    echo "$FUNCNAME: Invalid argument, not a directory";
    return 1;
  fi

  local filename="BROWSE";
  if [ $# -eq 2 ]; then
    filename="$2";
  fi

  pushd $1 1>/dev/null;
  local jobdir=`pwd`;

  echo -n "$FUNCNAME: Building Ebrowse in "$jobdir" ."
  findDirs;

  ablMkEbrowse "$filename" $dirlst;

  popd 1>/dev/null;

  echo "$FUNCNAME: -- DONE --"
  
  return 0;
}

# #####
# Effacement des bases Ebrowse du repertoire courant (fichiers de prefix .ebrowse)
cleanEbrowse ()
{
  local pushdir=0;
  if [ $# -eq 1 ]; then
    if [ x"$1" == x"help" ]; then
      echo "HELP: Effacement des bases Ebrowse du repertoire courant (fichiers de prefix .ebrowse)";
      return 0;
    elif [ -d "$1" ]; then
      pushd $1 1>/dev/null;
      pushdir=1;
    else
      echo "$FUNCNAME: Invalid argument ""$1";
    return 1;
    fi
  fi
  
  local jobdir=`pwd`;
  local browsefiles=`find ./ -type f -name "*.ebrowse"`;

  if [ z"$browsefiles" != z"" ]; then
    echo -n "$FUNCNAME: Cleaning Ebrowse in "$jobdir": "$browsefiles
    rm -f $browsefiles
    echo "."
  fi

  if [ $pushdir -eq 1 ]; then
    popd 1>/dev/null;
  fi
    
  return 0;
}

# #####
# Efface l'espace de debug RCU si present
cleanDebugRCUold ()
{

  local jobdir=`pwd`;
  if [ -d $jobdir/appli ]; then
    echo -e "Destruction de $jobdir/appli (o/n) ? \c";
    export choice=2;
    while [[ $choice -eq 2 ]]; do
      waitResponseYesNo;
      choice=$?;
    done
    if [[ $choice -eq 0 ]]; then
      echo "$jobdir/appli is destroyed";
      rm -rf $jobdir/appli;
    fi
  fi

  return 0;
}

# #####
# Nettoie l'espace de travail des bases cscope et etags
cleanJobspace ()
{

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Nettoie l'espace de travaille des bases cscope et etags";
    return 0;
  fi

  findDirs;
  local jobdir=`pwd`;
  
  local SAVE_IFS=$IFS
  IFS=$'\n'

  for dir in $dirlst; do
    if [[ -f $dir/cscope.files ]] || [[ -f $dir/cscope.out ]]; then
      cleanCscope $dir;
    fi
    if [ -f $dir/TAGS ]; then
      cleanTags $dir;
    fi
    cleanEbrowse $dir;
  done

  IFS=$SAVE_IFS

  cleanDebug;

  return 0;
}

# #####
# Creation du repertoire ed debug
mkDebugRCUold ()
{
  local pushdir=0;
  if [ $# -eq 1 ]; then
    if [ x"$1" == x"help" ]; then
      echo "HELP: Creation du repertoire de debug RCU dans l'espace des sources";
      return 0;
    elif [ -d $1 ]; then
      pushd $1 1>/dev/null;
      pushdir=1;
    else
      echo "$FUNCNAME: Invalid argument";
    return 1;
    fi
  fi
  
  local jobdir=`pwd`;

  if [ -d $jobdir/appli/lib ]; then
    echo "ERROR: RCU debug space already exists";
    return 1;
  fi

  mkdir $jobdir/appli;
  mkdir $jobdir/appli/lib;
  cd $jobdir/appli/lib;
  local solibs=`find ../.. -type f -name "*.so"`;
  for lib in $solibs; do echo $lib; ln -s $lib .; done
  cd $jobdir;
  
  if [ $pushdir -eq 1 ]; then
    popd 1>/dev/null;
  fi
    
  return 0;
}

# #####
# Creation du repertoire de debug
do_mkDebug ()
{
  local srcdir=`pwd`;
  local jobdir=$1
  local jobdir_plugins=$2

  if [ ! -d $jobdir ]; then
      echo "$FUNCNAME: $jobdir doesn't exist";
      return 1;
  fi
  
    if [ ! -d $jobdir_plugins ]; then
      echo "$FUNCNAME: $jobdir_plugins doesn't exist";
      return 1;
  fi
  
  cd $jobdir;
  local solibs=`find $srcdir -type f -name "*.so" | grep -v GEN_PC`;
  for lib in $solibs; do echo $jobdir/`basename $lib`; ln -s $lib $jobdir/`basename $lib`; done

  cd $jobdir_plugins;
  local solibs_plugins=`find $srcdir -type f -iname "librcuint*.so" | grep -v GEN_PC`;
  for lib in $solibs_plugins; do echo $jobdir_plugins/`basename $lib`; ln -s $lib $jobdir_plugins/`basename $lib`; done
  
  cd $srcdir;
   
   if [ $pushdir -eq 1 ]; then
     popd 1>/dev/null;
   fi
    
  return 0;

}

# #####
# Creation du repertoire de debug pour CLDK-1.3.1 et CLDK-1.4.0
mkDebug ()
{
  local pushdir=0;
  if [ $# -eq 1 ]; then
    if [ x"$1" == x"help" ]; then
      echo "HELP: Creation du repertoire de debug RCU dans l'espace des sources";
      return 0;
    elif [ -d $1 ]; then
      pushd $1 1>/dev/null;
      pushdir=1;
    else
      echo "$FUNCNAME: Invalid argument";
      return 1;
    fi
  fi
  
  local jobdir=/opt/cldk-1.3.1/ppc-linux/usr/local/lib
  local jobdir_plugins=/opt/cldk-1.3.1/ppc-linux/plugin_tmp
  
  do_mkDebug "$jobdir" "$jobdir_plugins"
  if [ $? -ne 0 ]; then
      echo "$FUNCNAME: cldk-1.3.1 mkdDebug has failed";
      return 1;
  fi
    
  jobdir=/opt/cldk-1.4.0/ppc-linux/usr/local/lib
  jobdir_plugins=/opt/cldk-1.4.0/ppc-linux/plugin_tmp
  
  do_mkDebug "$jobdir" "$jobdir_plugins"
  if [ $? -ne 0 ]; then
      echo "$FUNCNAME: cldk-1.4.0 mkDebug has failed";
      return 1;
  fi
    
  return 0;
}

# #####
# Efface les fichiers precises de l'espace de debug si present
do_rmlibs ()
{
  local solibs=$1;
  
  if [ z"$solibs" != z"" ]; then
   echo -e "Destruction de $solibs (o/n) ? \c";
   export choice=2;
   while [[ $choice -eq 2 ]]; do
     waitResponseYesNo;
     choice=$?;
   done
   if [[ $choice -eq 0 ]]; then
     for lib in $solibs; do echo "$lib is destroyed"; rm -f $lib; done
   fi
  fi

  return 0;
}

# #####
# Efface l'espace de debug si present
do_cleanDebug ()
{
  local rmdir=$1

  if [ ! -d $rmdir ]; then
    echo "$FUNCNAME: $rmdir doesn't exist";
    return 1;
  fi
  
  local solibs=`find $rmdir -type l -name "librcu*.so"`;
  do_rmlibs "$solibs";

  solibs=`find $rmdir -type l -name "libRStools.so"`;
  do_rmlibs "$solibs";
  
  solibs=`find $rmdir -type l -name "libED137V1.so"`;
  do_rmlibs "$solibs";
  
  return 0;
}

# #####
# Efface l'espace de debug si present pour CLDK-1.3.1 et CLDK-1.4.0
cleanDebug ()
{
  local srcdir=`pwd`;

  do_cleanDebug "/opt/cldk-1.3.1/ppc-linux/usr/local/lib"
  if [ $? -ne 0 ]; then
      echo "$FUNCNAME: cldk-1.3.1 cleanDebug has failed";
      return 1;
  fi
  do_cleanDebug "/opt/cldk-1.3.1/ppc-linux/plugin_tmp"
  if [ $? -ne 0 ]; then
      echo "$FUNCNAME: cldk-1.3.1 cleanDebug plugin_tmp has failed";
      return 1;
  fi
  
  do_cleanDebug "/opt/cldk-1.4.0/ppc-linux/usr/local/lib"
  if [ $? -ne 0 ]; then
      echo "$FUNCNAME: cldk-1.4.0 cleanDebug has failed";
      return 1;
  fi  
  do_cleanDebug "/opt/cldk-1.4.0/ppc-linux/plugin_tmp"
  if [ $? -ne 0 ]; then
      echo "$FUNCNAME: cldk-1.4.0 cleanDebug plugin_tmp has failed";
      return 1;
  fi
  
  return 0;
}

# #####
# Verifie les references externes de l'espace de travail
svnchkexternals ()
{
    local srcdir=`pwd`;
    findDirs $srcdir 1;
    local svndirs=$dirlst;

    svn propget svn:externals $srcdir
    echo "Check svn:externals above..."
    read
    echo ""
 
    local SAVE_IFS=$IFS
    IFS=$'\n'

    for dir in $svndirs; do
	echo -ne "-----" $dir"\n\t"
	svn info $dir | grep URL;
	echo ""
    done

    IFS=$SAVE_IFS

    echo ""
    echo "Check URLs above..."
 
    return 0;
}

# #####
# Indentation d'un fichier source
prettify ()
{
    local file=$1;
    local format=c;

    if [ $# -lt 1 ]; then
      echo "$FUNCNAME: Invalid argument";
      return 1;
    fi
    if [ $# -eq 2 ]; then
	format=$2;
    fi

    if [ z"$format" == z"c" ]; then
	echo "C style"
	indent -kr -l132 -nce -i8 -bad $file -o $file.pretty
    fi
    if [ z"$format" == z"cpp" ]; then
	echo "CPP style"
	indent -kr -l132 -nce -i8 -bad $file -o $file.pretty
    fi

    return 0;
}

# #####
# Lancement de la commande diff utilisant xxdiff
svnxxdiff ()
{
    local args="";
    local target="";

    if [ $# -eq 2 ]; then
	args="$1";
	target="$2";
    else
	if [ $# -ne 1 ]; then
	    echo "$FUNCNAME: Invalid argument";
	    return 1;
	fi
	target="$1";
    fi

    echo "Launching: svn diff --diff-cmd /home/ablangy/Project/scripts/xxdiff-subversion" $args $target
    svn diff --diff-cmd /home/ablangy/Project/scripts/xxdiff-subversion $args $target

    return $?
}

# #####
# Lancement de la commande diff utilisant xxdiff pour connaitre les dernires modifications
svnxxdiff_prev ()
{
	if [ $# -ne 1 ]; then
	    echo "$FUNCNAME: Invalid argument";
	    return 1;
	fi
	svnxxdiff "-r PREV:COMMITTED" $1
	return $?;
}

# #####
# grep dans les sources des repertoires en excluant .svn
csrcgrep ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: grep dans les repertoires en excluant .svn";
    return 0;
  fi

  local dir;
  findDirs
  local SAVE_IFS=$IFS
  IFS=$'\n'
  for dir in . $dirlst; do
      local files=`find $dir -iname "*.c" -o -iname "*.h" -o -iname "*.cpp" -o -iname "*.hpp" -o -iname "*.cc" -o -iname "*.tpl" -o -iname "*.asm"`;
      
      if [[ $1 == -* ]]; then
	  grep -n $1 --with-filename -- "$2" $files 2>/dev/null;
      else
	  grep -n --with-filename -- "$1" $files 2>/dev/null;
      fi
  done
  IFS=$SAVE_IFS

  return 0;
}

# #####
# Generation des bases Cscope et eTags
mkDB ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Generation des bases des fichiers sources situes dans des repertoires en excluant .svn et /TEST*";
    return 0;
  fi

  if [ ! -d $1 ]; then
    echo "$FUNCNAME: Invalid argument, not a directory";
    return 1;
  fi

  mkCscope $@;
  mkTags $@;

  return 0;
}

# #####
# Generation des bases Cscope et eTags des repertoires SRC uniquement
mkSrcDB ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  if [[ $# -eq 1 ]] && [[ x"$1" == x"help" ]]; then
    echo "HELP: Generation des bases des fichiers sources situes dans des repertoires SRC en excluant .svn et /TEST*";
    return 0;
  fi

  if [ ! -d $1 ]; then
    echo "$FUNCNAME: Invalid argument, not a directory";
    return 1;
  fi

  cleanCscope;
  cleanTags;
  mkSrcCscope $@;
  mkSrcTags $@;

  return 0;
}

# #####
# Appel de kdiff3 pour gerer un conflit SVN manuellement
kdiff3_conflict ()
{

  if [ $# -lt 1 ]; then
    echo "$FUNCNAME: Argument is missing";
    return 1;
  fi

  /usr/bin/kdiff3 $1.fusion-g* $1.courant $1.fusion-d* -m -o $1
  local rc=$?

  return rc
}
