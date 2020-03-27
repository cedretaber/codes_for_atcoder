import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    string r;
    foreach (_; 0..N) {
        auto line = readln.split;
        switch (line[0]) {
            case "BEGINNING": r ~= line[2][0]; break;
            case "END": r ~= line[2][$-1]; break;
            default: r ~= line[2][line[2].length/2];
        }
    }
    writeln(r);
}