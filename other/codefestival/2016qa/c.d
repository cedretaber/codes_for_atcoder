import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp.to!(char[]);
    auto K = readln.chomp.to!int;
    foreach (ref c; s) {
        if (c == 'a') continue;
        int i = c-'a';
        if (K < 26-i) continue;
        c = 'a';
        K -= 26-i;
    }
    if (K) {
        s[$-1] = ('a' + ((s[$-1] - 'a').to!int + K) % 26).to!char;
    }
    writeln(s);
}