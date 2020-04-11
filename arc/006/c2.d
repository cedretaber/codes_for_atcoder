import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto N = readln.chomp.to!int;
    int[] ws;
    foreach (_; 0..N) {
        auto w = readln.chomp.to!int;
        if (ws.empty) {
            ws ~= w;
        } else if (ws[$-1] < w) {
            ws ~= w;
        } else {
            foreach (ref ww; ws) if (ww >= w) {
                ww = w;
                break;
            }
        }
    }
    writeln(ws.length);
}