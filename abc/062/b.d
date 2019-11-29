import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto h = hw[0];
    auto w = hw[1];

    auto ret = "";

    foreach (_; 0..(w+1)) ret ~= "#";
    ret ~= "#\n";

    foreach (_; 0..h) {
        ret ~= "#";
        ret ~= readln.chomp;
        ret ~= "#\n";
    }

    foreach (_; 0..(w+2)) ret ~= "#";

    writeln(ret);
}