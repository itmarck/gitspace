import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:gitspace/main.dart';
import 'package:gitspace/repository.dart';
import 'package:gitspace/store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Repository> repositories = [];

  @override
  void initState() {
    super.initState();
    final account = Provider.of<Store>(context, listen: false).activeAccount;
    if (account != null) {
      fetchRepositories(account).then((repositories) {
        setState(() => this.repositories = repositories);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context, listen: false);
    final account = store.activeAccount;

    if (account == null) {
      return AddAccountPage(onChange: store.add);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 64.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                AppLocalizations.of(context)!.myProjects,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 32.0),
            Expanded(
              child: ListView(
                children: [
                  for (final repository in repositories)
                    Repo(repository: repository),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Repo extends StatelessWidget {
  final Repository repository;

  const Repo({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 16.0,
      ),
      child: Row(
        children: [
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(repository.name[0].toUpperCase()),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        repository.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    if (!repository.public)
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.lock,
                          size: 14.0,
                          color: Colors.white54,
                        ),
                      ),
                  ],
                ),
                Text(
                  repository.owner,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          const Icon(Icons.star),
          const SizedBox(width: 4.0),
          Text(repository.stars.toString()),
          const SizedBox(width: 16.0),
          const Icon(Icons.commit),
          const SizedBox(width: 4.0),
          Text(repository.openIssues.toString()),
        ],
      ),
    );
  }
}
