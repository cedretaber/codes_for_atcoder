import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto cs = new int[][](3, 3);
    foreach (i; 0..3) foreach (j, c; readln.split.to!(int[])) cs[i][j] = c;
    writeln(
        cs[1][0] - cs[0][0] == cs[1][1] - cs[0][1] &&
        cs[1][1] - cs[0][1] == cs[1][2] - cs[0][2] &&
        cs[2][0] - cs[0][0] == cs[2][1] - cs[0][1] &&
        cs[2][1] - cs[0][1] == cs[2][2] - cs[0][2] ?
        "Yes" : "No"
    );
}