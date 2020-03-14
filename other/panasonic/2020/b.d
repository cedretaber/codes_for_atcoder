import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(long[]);
    auto H = hw[0];
    auto W = hw[1];

    if (H == 1 || W == 1) {
        writeln(1);
    } else if((H*W)%2 == 0) {
        writeln(H*W/2);
    } else {
        writeln((H*(W-1)/2 + (H+1)/2));
    }
}