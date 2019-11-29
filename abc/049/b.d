import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto ret = "";
    auto h = readln.split[0].to!int;
    foreach (_; 0..h) {
        auto line = readln;
        ret ~= line ~ line;
    }
    write(ret);
}