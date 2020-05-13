import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.chomp.to!long;
    auto rs = new long[](50);
    if (K < 50) {
        foreach (ref r; rs[0..K]) r = 50;
    } else {
        rs[] = 49;
        foreach (ref r; rs) r += K / 50;
        auto m = K % 50;
        foreach (ref r; rs[0..m]) r += 50;
        foreach (ref r; rs) r -= K % 50;
    }
    writeln(50);
    writeln(rs.to!(string[]).join(" "));
}

/*

100 50 50 50 ...
99 49 49 49 ...
49 50 50 50 ...
50 0 51 51 ...
98 48 47 47 ...
48 49 48 48 ...

*/