//
//  ViewController.swift
//  MultiSliderSample
//
//  Created by Matteo Vidotto on 24/07/24.
//

import UIKit

class ViewController: UITableViewController {

    enum Section: Hashable {
        case magnitude
    }

    private enum Row: Hashable {
        case magnitudeIntervalValue
    }

    private var diffableDataSource: UITableViewDiffableDataSource<Section, Row>!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Filters"
        setupTableView()
        configureDataSource()
        createAndApplySnapshot(animated: false)
    }

    private func configureDataSource() {
        diffableDataSource = UITableViewDiffableDataSource<Section,Row>(
            tableView: tableView,
            cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
                guard let self
                else { return UITableViewCell() }

                switch itemIdentifier {
                case .magnitudeIntervalValue:
                    let cell = tableView.dequeueReusableCell(withIdentifier: MultiSliderTableViewCell.reuseIdentifier, for: indexPath) as! MultiSliderTableViewCell
                    cell.selectionStyle = .none
                    cell.slider.value = [0, 9]
                    cell.sliderValuesChanged = { [weak self] values in
                        guard let self else { return }
                        print(values.min, values.max)
                    }
                    return cell
                }
            }
        )
    }

    private func setupTableView() {
        tableView.register(MultiSliderTableViewCell.self, forCellReuseIdentifier: MultiSliderTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }

    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section, Row> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Row>()

        // Magnitude SECTION
        snapshot.appendSections([.magnitude])
        snapshot.appendItems(
            [.magnitudeIntervalValue],
            toSection: .magnitude
        )

        return snapshot
    }

    func createAndApplySnapshot(
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        let snapshot = createSnapshot()
        diffableDataSource.defaultRowAnimation = .fade
        diffableDataSource.apply(
            snapshot,
            animatingDifferences: animated,
            completion: completion
        )
    }

}

//MARK: - UITableViewDelegate
extension ViewController {
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
