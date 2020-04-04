import 'dart:io';
import 'package:path/path.dart' as p;

class MPDClient {

  MPDClient() {
    this._iterate = false;
    _reset();
    _getEnvVars();
  }

  String host;
  String pwd;
  String port;

  bool _iterate;
  bool _iterating;
  String mpd_version;
  List _pending;
  List _command_list;
  Socket _sock;
  String _rfile;
  String _wfile;

  static Map<String, Function> Commands = {
    // Status Commands
    "clearerror":         _fetchNothing,
    "currentsong":        _fetchObject,
    "idle":               _fetchList,
    //"noidle":             None,
    "status":             _fetchObject,
    "stats":              _fetchObject,
    // Playback Option Commands
    "consume":            _fetchNothing,
    "crossfade":          _fetchNothing,
    "mixrampdb":          _fetchNothing,
    "mixrampdelay":       _fetchNothing,
    "random":             _fetchNothing,
    "repeat":             _fetchNothing,
    "setvol":             _fetchNothing,
    "single":             _fetchNothing,
    "replay_gainMode":   _fetchNothing,
    "replay_gainStatus": _fetchItem,
    "volume":             _fetchNothing,
    // Playback Control Commands
    "next":               _fetchNothing,
    "pause":              _fetchNothing,
    "play":               _fetchNothing,
    "playid":             _fetchNothing,
    "previous":           _fetchNothing,
    "seek":               _fetchNothing,
    "seekid":             _fetchNothing,
    "seekcur":            _fetchNothing,
    "stop":               _fetchNothing,
    // Queue Commands
    "add":                _fetchNothing,
    "addid":              _fetchItem,
    "clear":              _fetchNothing,
    "delete":             _fetchNothing,
    "deleteid":           _fetchNothing,
    "move":               _fetchNothing,
    "moveid":             _fetchNothing,
    "playlist":           _fetchPlaylist,
    "playlistfind":       _fetchSongs,
    "playlistid":         _fetchSongs,
    "playlistinfo":       _fetchSongs,
    "playlistsearch":     _fetchSongs,
    "plchanges":          _fetchSongs,
    "plchangesposid":     _fetchChanges,
    "prio":               _fetchNothing,
    "prioid":             _fetchNothing,
    "rangeid":            _fetchNothing,
    "shuffle":            _fetchNothing,
    "swap":               _fetchNothing,
    "swapid":             _fetchNothing,
    "addtagid":           _fetchNothing,
    "cleartagid":         _fetchNothing,
    // Stored Playlist Commands
    "listplaylist":       _fetchList,
    "listplaylistinfo":   _fetchSongs,
    "listplaylists":      _fetchPlaylists,
    "load":               _fetchNothing,
    "playlistadd":        _fetchNothing,
    "playlistclear":      _fetchNothing,
    "playlistdelete":     _fetchNothing,
    "playlistmove":       _fetchNothing,
    "rename":             _fetchNothing,
    "rm":                 _fetchNothing,
    "save":               _fetchNothing,
    // Database Commands
    "albumart":           _fetchComposite,
    "count":              _fetchObject,
    "find":               _fetchSongs,
    "findadd":            _fetchNothing,
    "list":               _fetchList,
    "listall":            _fetchDatabase,
    "listallinfo":        _fetchDatabase,
    "listfiles":          _fetchDatabase,
    "lsinfo":             _fetchDatabase,
    "readcomments":       _fetchObject,
    "search":             _fetchSongs,
    "searchadd":          _fetchNothing,
    "searchaddpl":        _fetchNothing,
    "update":             _fetchItem,
    "rescan":             _fetchItem,
    // Mounts and neighbors
    "mount":              _fetchNothing,
    "unmount":            _fetchNothing,
    "listmounts":         _fetchMounts,
    "listneighbors":      _fetchNeighbors,
    // Sticker Commands
    "sticker get":        _fetchItem,
    "sticker set":        _fetchNothing,
    "sticker delete":     _fetchNothing,
    "sticker list":       _fetchList,
    "sticker find":       _fetchSongs,
    // Connection Commands
    "close":              null,
    "kill":               null,
    "password":           _fetchNothing,
    "ping":               _fetchNothing,
    "tagtypes":           _fetchList,
    "tagtypes disable":   _fetchNothing,
    "tagtypes enable":    _fetchNothing,
    "tagtypes clear":     _fetchNothing,
    "tagtypes all":       _fetchNothing,
    // Partition Commands
    "partition":          _fetchNothing,
    "listpartitions":     _fetchList,
    "newpartition":       _fetchNothing,
    // Audio Output Commands
    "disableoutput":      _fetchNothing,
    "enableoutput":       _fetchNothing,
    "toggleoutput":       _fetchNothing,
    "outputs":            _fetchOutputs,
    "outputset":          _fetchNothing,
    // Reflection Commands
    "config":             _fetchObject,
    "commands":           _fetchList,
    "notcommands":        _fetchList,
    "urlhandlers":        _fetchList,
    "decoders":           _fetchPlugins,
    // Client to Client
    "subscribe":          _fetchNothing,
    "unsubscribe":        _fetchNothing,
    "channels":           _fetchList,
    "readmessages":       _fetchMessages,
    "sendmessage":        _fetchNothing,
  };

  void _hello() {
    throw UnimplementedError();
  }

  void _reset() {
    this.mpd_version = null;
    this._iterating = false;
    this._pending = [];
    this._command_list = null;
    this._sock = null;
    this._rfile = null;
    this._wfile = null;
  }

  Future<Socket> _connectUnix(String path) {
    throw UnimplementedError();
  }

  Future<Socket> _connectTCP(String path, String port) {
    throw UnimplementedError();
  }

  void _getEnvVars() {
    Map<String, String> env = Platform.environment;
    List<String> mpdHostVars;
    String runDir;

    this.host = "localhost";
    this.pwd = null;
    this.port = env["MPD_PORT"] ?? "6600";

    if(env["MPD_HOST"] != null) {
      mpdHostVars = env["MPD_HOST"].split("@").reversed;
      this.host = mpdHostVars[0];
      if(mpdHostVars.length > 1){
        this.pwd = mpdHostVars[1];
      }
    } else {
      runDir = p.join(
        ["XDG_RUNTIME_DIR"] ?? "/run",
        "mpd/socket"
      );
      if(Directory(runDir).existsSync()) {
        this.host = runDir;
      }
    }
  }

  static void _fetchNothing() {

  }
  
  static void _fetchItem() {

  }

  static void _fetchList() {

  }

  static void _fetchPlaylist() {

  }

  static void _fetchObject() {

  }

  static void _fetchObjects() {

  }

  static void _fetchChanges() {

  }

  static void _fetchSongs() {

  }

  static void _fetchPlaylists() {

  }
  
  static void _fetchDatabase() {

  }

  static void _fetchOutputs() {

  }

  static void _fetchPlugins() {

  }

  static void _fetchMessages() {

  }

  static void _fetchMounts() {

  }

  static void _fetchNeighbors() {

  }
  
  static void _fetchComposite() {

  }

  void connect({String host, String port}) async {
    host ??= this.host;
    this.host = host;

    port ??= this.port;
    this.port = port;

    if(this._sock != null) {
      throw ConnectionError("Already connected");
    }
    if(host.startsWith("/")) {
      this._sock = await _connectUnix(host);
    } else {
      this._sock = await _connectTCP(host, port);
    }

    try {
      _hello();
    } catch(e) {
      disconnect();
      throw e;
    }
  }

  void disconnect() {
    this._sock.close();
    _reset();;
  }
}

class MPDError implements Exception {

}

class ConnectionError extends MPDError {
  ConnectionError(this.cause);
  String cause;
}