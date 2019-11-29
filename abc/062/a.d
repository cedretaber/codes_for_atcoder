import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[] LONGM = [1,3,5,7,8,10,12];
int[] SHORTM = [4,6,9,11];

void main()
{
    auto xy = readln.split.to!(int[]);

    writeln(
        xy.all!(i => LONGM.canFind(i)) || xy.all!(i => SHORTM.canFind(i)) ? "Yes" : "No"
    );
}
