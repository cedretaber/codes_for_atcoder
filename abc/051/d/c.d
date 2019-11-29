import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto stxy = readln.split.to!(int[]);
    auto xd = stxy[2] - stxy[0];
    auto yd = stxy[3] - stxy[1];

    string ret;
    foreach (_; 0..yd) ret ~= "U";
    foreach (_; 0..xd) ret ~= "R";
    foreach (_; 0..yd) ret ~= "D";
    foreach (_; 0..xd+1) ret ~= "L";
    foreach (_; 0..yd+1) ret ~= "U";
    foreach (_; 0..xd+1) ret ~= "R";
    ret ~= "DR";
    foreach (_; 0..yd+1) ret ~= "D";
    foreach (_; 0..xd+1) ret ~= "L";
    ret ~= "U";

    writeln(ret);
}